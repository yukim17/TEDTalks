//
//  VideosView.swift
//  TEDTalks
//
//  Created by Ekaterina Grishina on 23/11/22.
//

import SwiftUI
import ComposableArchitecture

struct VideosView: View {
    
    let store: Store<VideosState, VideosAction>
    
    var body: some View {
        
        WithViewStore(store) { viewStore in
            
            NavigationView {
                ScrollView {
                    Group {
                        if viewStore.isLoading {
                            VStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        } else {
                            VStack {
                                itemsList(viewStore)
                            }
                        }
                    }
                    .padding()
                }
                .background(Color("background"))
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarTitle("Videos")
                .preferredColorScheme(.dark)
            }
            .onAppear { viewStore.send(.onAppear) }
            .onDisappear { viewStore.send(.onDisappear) }
        }
    }
    
    
}

// MARK: - Views

extension VideosView {
    @ViewBuilder
    private func itemsList(_ viewStore: ViewStore<VideosState, VideosAction>) -> some View {
        let gridItem = GridItem(.flexible(minimum: 80, maximum: 180))
        LazyVGrid(
            columns: [gridItem, gridItem],
            alignment: .center,
            spacing: 16,
            content: { videosListItem(viewStore) }
        )
    }
    
    @ViewBuilder
    private func videosListItem(_ viewStore: ViewStore<VideosState, VideosAction>) -> some View {
        ForEachStore(
            store.scope(
                state: { $0.videos },
                action: VideosAction.video(id:action:)
            ),
            content: { videoStore in
                WithViewStore(videoStore) { videoViewStore in
                    NavigationLink(
                        destination: VideoDetailView(store: videoStore),
                        label: {
                            VideoItemView(
                                video: videoViewStore.state.video,
                                isFavorite: viewStore.state.isFavorite(with: videoViewStore.state.video)
                            )
                            .onAppear {
                                viewStore.send(.retrieveNextPageIfNeeded(currentItem: videoViewStore.state.id))
                            }
                        }
                    )
                }
            }
        )
    }
}

// MARK: - Previews

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        VideosView(
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
                reducer: videosReducer,
                environment: VideosEnvironment(
                    videosClient: .mockPreview(),
                    favoriteVideosClient: .mockPreview(),
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                    uuid: UUID.init
                )
            )
        )
    }
}
