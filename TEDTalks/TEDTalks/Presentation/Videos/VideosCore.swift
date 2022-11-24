//
//  VideosCore.swift
//  TEDTalks
//
//  Created by Ekaterina Grishina on 23/11/22.
//

import Foundation
import ComposableArchitecture

struct VideosState: Equatable {
    var videos = IdentifiedArrayOf<VideoDetailState>()
    var favorites = [Video]()
    
    var currentPage = 1
    let pageSize = 15
    var isLoading = false
    var isLoadingPage = false
    
    // HELPER
    
    func isFavorite(with video: Video) -> Bool {
        return favorites.contains(where: { $0.id == video.id })
    }
    
    func isLastItem(_ item: UUID) -> Bool {
        let itemIndex = videos.firstIndex(where: { $0.id == item })
        return itemIndex == videos.endIndex - 1
    }
}

enum VideosAction: Equatable {
    case retrieve
    case retrieveNextPageIfNeeded(currentItem: UUID)
    case videosResponse(Result<[Video], NetworkError>)
    
    case retrieveFavorites
    case favoritesResponse(Result<[Video], Never>)
    
    case loadingActive(Bool)
    case loadingPageActive(Bool)
    
    case video(id: UUID, action: VideoDetailAction)
    
    case onAppear
    case onDisappear
}

struct VideosEnvironment {
    var videosClient: VideosRepository
    var favoriteVideosClient: FavoriteVideosRepository
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var uuid: () -> UUID
}

// MARK: - Reducer

let videosReducer = Reducer<VideosState, VideosAction, VideosEnvironment>.combine(
    videoDetailReducer.forEach(
        state: \VideosState.videos,
        action: /VideosAction.video(id:action:),
        environment: { environment in
            VideoDetailEnvironment(
                favoriteVideosClient: .mock(),
                mainQueue: environment.mainQueue
            )
        }
    ),
    .init { state, action, environment in
        
        struct VideosCancelId: Hashable {}
        
        switch action {
        case .onAppear:
            guard state.videos.isEmpty else { return EffectTask(value: VideosAction.retrieveFavorites) }
            return EffectTask(value: .retrieve)
            
        case .retrieve:
            state.videos = []
            state.currentPage = 1
            return .concatenate(
                .init(value: .loadingActive(true)),
                environment.videosClient
                    .page(state.currentPage, state.pageSize)
                    .receive(on: environment.mainQueue)
                    .catchToEffect()
                    .map(VideosAction.videosResponse)
                    .cancellable(id: VideosCancelId()),
                .init(value: .retrieveFavorites)
            )
            
        case .retrieveNextPageIfNeeded(currentItem: let item):
            guard
                state.isLastItem(item),
                !state.isLoadingPage
            else { return .none }
            
            state.currentPage += 1
            return .concatenate(
                .init(value: .loadingPageActive(true)),
                environment.videosClient
                    .page(state.currentPage, state.pageSize)
                    .receive(on: environment.mainQueue)
                    .catchToEffect()
                    .map(VideosAction.videosResponse)
                    .cancellable(id: VideosCancelId())
            )
            
        case .retrieveFavorites:
            return environment.favoriteVideosClient
                .all()
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(VideosAction.favoritesResponse)
                .cancellable(id: VideosCancelId())
            
        case .videosResponse(.success(let videos)):
            videos.forEach {
                state.videos.append(VideoDetailState(
                    id: environment.uuid(),
                    video: $0
                ))
            }
            
            return .concatenate(
                .init(value: .loadingActive(false)),
                .init(value: .loadingPageActive(false))
            )
            
        case .videosResponse(.failure(let error)):
            return .concatenate(
                .init(value: .loadingActive(false)),
                .init(value: .loadingPageActive(false))
            )
            
        case .favoritesResponse(.success(let favorites)):
            state.favorites = favorites
            return .none
            
        case .loadingActive(let isLoading):
            state.isLoading = isLoading
            return .none
            
        case .loadingPageActive(let isLoading):
            state.isLoadingPage = isLoading
            return .none
            
        case .video(id: _, action: .onDisappear):
            return .init(value: .retrieveFavorites)
            
        case .video(id: _, action: _):
            return .none
            
        case .onDisappear:
            return .cancel(id: VideosCancelId())
        }
    }
)
