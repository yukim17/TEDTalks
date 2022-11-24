//
//  Video.swift
//  TEDTalks
//
//  Created by Ekaterina Grishina on 23/11/22.
//

import Foundation

struct Video: Hashable, Codable {
    let id: UUID
    let name: String
    let url: String
    let thumbnailUrl: String
    let description: String
}

extension Video {
    static var mock: [Video] = [
        Video(
            id: UUID(),
            name: "What you can learn from people who disagree with you",
            url: "",
            thumbnailUrl: "https://pi.tedcdn.com/r/talkstar-photos.s3.amazonaws.com/uploads/b607d9b7-3432-4b33-8e37-b6e5aebc16c3/ShreyaJoshi_2022-embed.jpg?u%5Br%5D=2&u%5Bs%5D=0.5&u%5Ba%5D=0.8&u%5Bt%5D=0.03&quality=80&w=3840",
            description: """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        ),
        Video(
            id: UUID(),
            name: "Do you really need 8 hours of sleep every night?",
            url: "",
            thumbnailUrl: "https://pi.tedcdn.com/r/talkstar-photos.s3.amazonaws.com/uploads/d2b35cd7-c01c-4475-b0d7-c588ee98b34b/BodyStuff_2022V_E03-embed.jpg?u%5Br%5D=2&u%5Bs%5D=0.5&u%5Ba%5D=0.8&u%5Bt%5D=0.03&quality=80&w=1080",
            description: """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        ),
        Video(
            id: UUID(),
            name: "Language shouldn't be a barrier to climate action",
            url: "",
            thumbnailUrl: "https://pi.tedcdn.com/r/talkstar-photos.s3.amazonaws.com/uploads/0f45eea1-0722-4ac1-a7fb-504e5ce877ec/SophiaKianni_2021T-embed.jpg?u%5Br%5D=2&u%5Bs%5D=0.5&u%5Ba%5D=0.8&u%5Bt%5D=0.03&quality=80&w=1080",
            description: """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        ),
        Video(
            id: UUID(),
            name: "A short history of trans people's long fight for equality",
            url: "",
            thumbnailUrl: "https://pi.tedcdn.com/r/talkstar-photos.s3.amazonaws.com/uploads/0074e57b-6f8c-43d5-88a3-01142deac039/SamyNourYounes_2018S-embed.jpg?u%5Br%5D=2&u%5Bs%5D=0.5&u%5Ba%5D=0.8&u%5Bt%5D=0.03&quality=80&w=1080",
            description: """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        ),
        Video(
            id: UUID(),
            name: "The benefits of not being a jerk to yourself",
            url: "",
            thumbnailUrl: "https://pi.tedcdn.com/r/talkstar-photos.s3.amazonaws.com/uploads/2a31a479-5c1e-4422-8faf-b290c5c330b0/DanHarris_2022-embed.jpg?u%5Br%5D=2&u%5Bs%5D=0.5&u%5Ba%5D=0.8&u%5Bt%5D=0.03&quality=80&w=1080",
            description: """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        ),
        Video(
            id: UUID(),
            name: "Why you procrastinate even when it feels bad",
            url: "",
            thumbnailUrl: "https://pi.tedcdn.com/r/talkstar-photos.s3.amazonaws.com/uploads/6c9134fd-bd96-449a-b6e0-481028ae4d17/procrastination.jpg?u%5Br%5D=2&u%5Bs%5D=0.5&u%5Ba%5D=0.8&u%5Bt%5D=0.03&quality=80&w=1080",
            description: """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        ),
        Video(
            id: UUID(),
            name: "You don't actually know what your future self wants",
            url: "",
            thumbnailUrl: "https://pi.tedcdn.com/r/talkstar-photos.s3.amazonaws.com/uploads/d56cd032-6a33-4103-9f12-d79bbf727268/ShankarVedantam_2022-embed.jpg?u%5Br%5D=2&u%5Bs%5D=0.5&u%5Ba%5D=0.8&u%5Bt%5D=0.03&quality=80&w=1080",
            description: """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        ),
        Video(
            id: UUID(),
            name: "Behind the lies of Holocaust denial",
            url: "",
            thumbnailUrl: "https://pi.tedcdn.com/r/talkstar-photos.s3.amazonaws.com/uploads/85bb00d6-3189-4c08-833c-26a2b4c7290b/DeborahLipstadt_2017X-embed.jpg?u%5Br%5D=2&u%5Bs%5D=0.5&u%5Ba%5D=0.8&u%5Bt%5D=0.03&quality=80&w=1080",
            description: """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        ),
        Video(
            id: UUID(),
            name: "5 parenting tips for raising resilient, self-reliant kids",
            url: "",
            thumbnailUrl: "https://pi.tedcdn.com/r/talkstar-photos.s3.amazonaws.com/uploads/fde0c3fa-ea40-4469-8e8c-aeaa8ce00fee/TamekaMontgomery_2022X-embed.jpg?u%5Br%5D=2&u%5Bs%5D=0.5&u%5Ba%5D=0.8&u%5Bt%5D=0.03&quality=80&w=1080",
            description: """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        )
    ]
}
