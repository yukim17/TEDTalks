//
//  VideoItemView.swift
//  TEDTalks
//
//  Created by Ekaterina Grishina on 23/11/22.
//

import Kingfisher
import SwiftUI

struct VideoItemView: View {
    let video: Video
    let isFavorite: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            KFImage(URL(string: video.thumbnailUrl))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(video.name)
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                }
            }
        }
    }
}

// MARK: - Previews

struct CardItemView_Previews: PreviewProvider {
    static var previews: some View {
        VideoItemView(video: Video(id: UUID(), name: "Video 1", url: "", thumbnailUrl: "", description: ""), isFavorite: true)
    }
}
