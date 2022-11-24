//
//  FavouritesView.swift
//  TEDTalks
//
//  Created by Ekaterina Grishina on 23/11/22.
//

import ComposableArchitecture
import SwiftUI

struct FavoritesView: View {
    var store: Store<FavoritesState, FavoritesAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                ScrollView {
                    itemsList(viewStore)
//                        .padding()
                }
                .background(Color("background"))
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarTitle("Favourites")
                .preferredColorScheme(.dark)
            }
            .onAppear { viewStore.send(.onAppear) }
            .onDisappear { viewStore.send(.onDisappear) }
        }
    }
}

// MARK: - Views

extension FavoritesView {
    @ViewBuilder
    private func itemsList(_ viewStore: ViewStore<FavoritesState, FavoritesAction>) -> some View {
        let gridItem = GridItem(.flexible(minimum: 80, maximum: 180))
        LazyVGrid(
            columns: [gridItem, gridItem],
            alignment: .center,
            spacing: 16,
            content: { cardsList(viewStore) }
        )
    }
    
    @ViewBuilder
    private func cardsList(_ viewStore: ViewStore<FavoritesState, FavoritesAction>) -> some View {
        ForEachStore(
            store.scope(
                state: { $0.videos },
                action: FavoritesAction.video(id:action:)
            ),
            content: { cardStore in
                WithViewStore(cardStore) { cardViewStore in
                    NavigationLink(
                        destination: VideoDetailView(store: cardStore),
                        label: {
                            VideoItemView(
                                video: cardViewStore.state.video,
                                isFavorite: true
                            )
                        }
                    )
                }
            }
        )
    }
}

// MARK: - Previews

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(
            store: .init(
                initialState: .init(
                    videos: .init(
                        uniqueElements: Video.mock.map {
                            VideoDetailState(
                                id: .init(),
                                video: $0
                            )
                        }
                    )
                ),
                reducer: favoritesReducer,
                environment: .init(
                    favoriteVideosClient: .mockPreview(),
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                    uuid: UUID.init
                )
            )
        )
    }
}
