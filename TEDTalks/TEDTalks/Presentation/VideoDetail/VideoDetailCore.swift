//
//  VideoDetailsCore.swift
//  TEDTalks
//
//  Created by Ekaterina Grishina on 23/11/22.
//

import Foundation
import ComposableArchitecture

struct VideoDetailState: Equatable, Identifiable {
    let id: UUID
    var video: Video
    
    var isFavorite = false
    var favorites = [Video]()
}

enum VideoDetailAction: Equatable {
    case onAppear
    case onDisappear
    
    case toggleFavorite
    case favoritesResponse(Result<[Video], Never>)
    case toggleFavoriteResponse(Result<[Video], Never>)
}

struct VideoDetailEnvironment {
    var favoriteVideosClient: FavoriteVideosRepository
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

// MARK: - Reducer

let videoDetailReducer = Reducer<VideoDetailState, VideoDetailAction, VideoDetailEnvironment> { state, action, environment in
    
    struct VideoDetailCancelId: Hashable {}
    
    switch action {
    case .onAppear:
        return environment.favoriteVideosClient
            .all()
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(VideoDetailAction.favoritesResponse)
            .cancellable(id: VideoDetailCancelId())
        
    case .favoritesResponse(.success(let favorites)),
            .toggleFavoriteResponse(.success(let favorites)):
        state.favorites = favorites
        state.isFavorite = favorites.contains(where: { $0.id == state.video.id })
        return .none
        
    case .toggleFavorite:
        if state.isFavorite {
            return environment.favoriteVideosClient
                .remove(state.video)
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(VideoDetailAction.toggleFavoriteResponse)
                .cancellable(id: VideoDetailCancelId())
        } else {
            return environment.favoriteVideosClient
                .add(state.video)
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(VideoDetailAction.toggleFavoriteResponse)
                .cancellable(id: VideoDetailCancelId())
        }
        
    case .onDisappear:
        return .cancel(id: VideoDetailCancelId())
    }
}
