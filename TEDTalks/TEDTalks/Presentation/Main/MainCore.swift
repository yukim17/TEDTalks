//
//  MainCore.swift
//  TEDTalks
//
//  Created by Ekaterina Grishina on 23/11/22.
//

import ComposableArchitecture
import Foundation

struct MainState: Equatable {
    var videosState = VideosState()
    var favoritesState = FavoritesState()
    
    enum Tab {
        case videos
        case favorites
    }
    
    var selectedTab = Tab.videos
}

enum MainAction {
    case videos(VideosAction)
    case favorites(FavoritesAction)
    
    case selectedTabChange(MainState.Tab)
}

struct MainEnvironment {
    var videosClient: VideosRepository
    var favoriteVideosClient: FavoriteVideosRepository
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var uuid: () -> UUID
}

// MARK: - Reducer

let mainReducer: Reducer<MainState, MainAction, MainEnvironment> = .combine(
    videosReducer.pullback(
        state: \MainState.videosState,
        action: /MainAction.videos,
        environment: { environment in
            VideosEnvironment(
                videosClient: environment.videosClient,
                favoriteVideosClient: environment.favoriteVideosClient,
                mainQueue: environment.mainQueue,
                uuid: environment.uuid
            )
        }
    ),
    favoritesReducer.pullback(
        state: \MainState.favoritesState,
        action: /MainAction.favorites,
        environment: { environment in
            FavoritesEnvironment(
                favoriteVideosClient: environment.favoriteVideosClient,
                mainQueue: environment.mainQueue,
                uuid: environment.uuid
            )
        }
    ),
    .init { state, action, environment in
        
        switch action {
        case .videos(.video(id: _, action: .toggleFavoriteResponse(.success(let favorites)))):
            state.favoritesState.videos = .init(
                uniqueElements: favorites.map {
                    VideoDetailState(
                        id: environment.uuid(),
                        video: $0
                    )
                }
            )
            return .none
            
        case .videos:
            return .none
            
        case .favorites(.video(id: _, action: .toggleFavoriteResponse(.success(let favorites)))):
            state.videosState.favorites = favorites
            return .none
            
        case .favorites:
            return .none
            
        case .selectedTabChange(let selectedTab):
            state.selectedTab = selectedTab
            return .none
        }
    }
)
