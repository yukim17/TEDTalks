//
//  VideoDetailsView.swift
//  TEDTalks
//
//  Created by Ekaterina Grishina on 23/11/22.
//

import ComposableArchitecture
import Kingfisher
import SwiftUI

struct VideoDetailView: View {
    
    let store: Store<VideoDetailState, VideoDetailAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                KFImage(URL(string: viewStore.video.thumbnailUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
//                    .padding(.horizontal, 16)
                Text(viewStore.video.name)
                    .font(.title)
//                    .padding(.horizontal, 16)
                Text(viewStore.video.description)
                    .font(.callout)
                    .padding(.top, 10)
                Spacer()
            }
            .padding(.horizontal, 16)
            .background(Color("background"))
            .navigationBarTitleDisplayMode(.inline)
            .onAppear { viewStore.send(.onAppear) }
            .onDisappear { viewStore.send(.onDisappear) }
        }
    }
}

// MARK: - Views

extension VideoDetailView {
    @ViewBuilder
    private func favoriteButton(_ viewStore: ViewStore<VideoDetailState, VideoDetailAction>) -> some View {
        WithViewStore(store.scope(state: { $0.isFavorite })) { favoriteViewStore in
            //      FavoriteButton(
            //        action: { viewStore.send(.toggleFavorite) },
            //        isFavorite: favoriteViewStore.state
            //      )
        }
    }
}

// MARK: - Previews

struct VideoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VideoDetailView(
                store: .init(
                    initialState: VideoDetailState(
                        id: .init(),
                        video: Video.mock[0]
                    ),
                    reducer: videoDetailReducer,
                    environment: .init(
                        favoriteVideosClient: .mockPreview(),
                        mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                    )
                )
            )
        }
    }
}
