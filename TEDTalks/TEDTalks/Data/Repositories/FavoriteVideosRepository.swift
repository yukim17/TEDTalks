//
//  FavoriteCardsRepository.swift
//  TEDTalks
//
//  Created by Ekaterina Grishina on 23/11/22.
//

import ComposableArchitecture

struct FavoriteVideosRepository {
    var all: () -> Effect<[Video], Never>
    var add: (_ card: Video) -> Effect<[Video], Never>
    var remove: (_ card: Video) -> Effect<[Video], Never>
}

// MARK: - Mock

extension FavoriteVideosRepository {
    static func mock(
        all: @escaping () -> Effect<[Video], Never> = {
            .init(value: [Video.mock[0]])
        },
        add: @escaping (Video) -> Effect<[Video], Never> = { _ in
            .init(value: [Video.mock[1]])
        },
        remove: @escaping (Video) -> Effect<[Video], Never> = { _ in
            .init(value: [])
        }
    ) -> Self {
        Self(
            all: all,
            add: add,
            remove: remove
        )
    }
    
    static func mockPreview(
        all: @escaping () -> Effect<[Video], Never> = {
            .init(value: [Video.mock[0]])
        },
        add: @escaping (Video) -> Effect<[Video], Never> = { _ in
            .init(value: [Video.mock[1]])
        },
        remove: @escaping (Video) -> Effect<[Video], Never> = { _ in
            .init(value: [])
        }
    ) -> Self {
        Self(
            all: all,
            add: add,
            remove: remove
        )
    }
}
