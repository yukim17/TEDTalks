//
//  TEDTalksApp.swift
//  TEDTalks
//
//  Created by Ekaterina Grishina on 16/11/22.
//

import SwiftUI

@main
struct TEDTalksApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(
              store: .init(
                initialState: .init(),
                reducer: mainReducer,
                environment: .init(
                  videosClient: .mock(),
                  favoriteVideosClient: .mock(),
                  mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                  uuid: UUID.init
                )
              )
            )
        }
    }
}
