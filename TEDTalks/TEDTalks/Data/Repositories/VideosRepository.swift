//
//  CardsRepository.swift
//  TEDTalks
//
//  Created by Ekaterina Grishina on 23/11/22.
//

import ComposableArchitecture
import Foundation

struct VideosRepository {
    var page: (_ number: Int, _ size: Int) -> Effect<VideosRequest.Response, NetworkError>
}

// MARK: - Live

extension VideosRepository {
    static let live = VideosRepository(page: { number, size in
        return DefaultNetworkService.shared.executeRequest(VideosRequest()).eraseToEffect()
    })
}

// MARK: - Mock

extension VideosRepository {
    static func mock(
        all: @escaping (Int, Int) -> Effect<[Video], NetworkError> = { _, _ in
            .init(value: Video.mock)
        }
    ) -> Self {
        Self(
            page: all
        )
    }
    
    static func mockPreview(
        all: @escaping (Int, Int) -> Effect<[Video], NetworkError> = { _, _ in
            .init(value: Video.mock)
        }
    ) -> Self {
        Self(
            page: all
        )
    }
}
