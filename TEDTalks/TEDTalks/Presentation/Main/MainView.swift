//
//  MainView.swift
//  TEDTalks
//
//  Created by Ekaterina Grishina on 23/11/22.
//

import ComposableArchitecture
import SwiftUI

struct MainView: View {
    
    let store: Store<MainState, MainAction>
    
    init(store: Store<MainState, MainAction>) {
        self.store = store
        UITabBar.appearance().backgroundColor = UIColor(named: "tabbarBackground")
    }
    
    var body: some View {
        WithViewStore(store) { viewStore in
            TabView(
                selection: viewStore.binding(
                    get: { $0.selectedTab },
                    send: MainAction.selectedTabChange
                ),
                content: {
                    Group {
                        VideosView(store: videosStore)
                            .tabItem {
                                Image(systemName: "video")
                                Text("Videos")
                            }
                            .tag(MainState.Tab.videos)
                        FavoritesView(store: favoritesStore)
                            .tabItem {
                                Image(systemName: "bookmark")
                                Text("Favourites")
                            }
                            .tag(MainState.Tab.favorites)
                    }
                }
            )
        }
    }
}

// MARK: - Store inits

extension MainView {
    private var videosStore: Store<VideosState, VideosAction> {
        return store.scope(
            state: { $0.videosState },
            action: MainAction.videos
        )
    }
    
    private var favoritesStore: Store<FavoritesState, FavoritesAction> {
        return store.scope(
            state: { $0.favoritesState },
            action: MainAction.favorites
        )
    }
}

// MARK: - Previews

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            store: .init(
                initialState: MainState(),
                reducer: mainReducer,
                environment: .init(
                    videosClient: .mockPreview(),
                    favoriteVideosClient: .mockPreview(),
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                    uuid: UUID.init
                )
            )
        )
    }
}
