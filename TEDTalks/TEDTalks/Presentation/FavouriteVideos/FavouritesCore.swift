//
//  FavouritesCore.swift
//  TEDTalks
//
//  Created by Ekaterina Grishina on 23/11/22.
//

import Foundation
import ComposableArchitecture

struct FavoritesState: Equatable {
    var videos = IdentifiedArrayOf<VideoDetailState>()
}

enum FavoritesAction: Equatable {
    case retrieveFavorites
    case favoritesResponse(Result<[Video], Never>)
    
    case video(id: UUID, action: VideoDetailAction)
    
    case onAppear
    case onDisappear
}

struct FavoritesEnvironment {
    var favoriteVideosClient: FavoriteVideosRepository
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var uuid: () -> UUID
}

// MARK: - Reducer

let favoritesReducer =
Reducer<FavoritesState, FavoritesAction, FavoritesEnvironment>.combine(
    videoDetailReducer.forEach(
        state: \.videos,
        action: /FavoritesAction.video(id:action:),
        environment: { environment in
                .init(
                    favoriteVideosClient: environment.favoriteVideosClient,
                    mainQueue: environment.mainQueue
                )
        }
    ),
    .init { state, action, environment in
        
        struct FavoritesCancelId: Hashable {}
        
        switch action {
        case .onAppear:
            guard state.videos.isEmpty else { return .none }
            return .init(value: .retrieveFavorites)
            
        case .retrieveFavorites:
            return environment.favoriteVideosClient
                .all()
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(FavoritesAction.favoritesResponse)
                .cancellable(id: FavoritesCancelId())
            
        case .favoritesResponse(.success(let favorites)):
            state.videos = .init(
                uniqueElements: favorites.map {
                    VideoDetailState(
                        id: environment.uuid(),
                        video: $0
                    )
                }
            )
            return .none
            
        case .video(id: _, action: .onDisappear):
            return .init(value: .retrieveFavorites)
            
        case .video(id: _, action: _):
            return .none
            
        case .onDisappear:
            return .cancel(id: FavoritesCancelId())
        }
    }
)
