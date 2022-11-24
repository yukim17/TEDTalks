//
//  VideosRequest.swift
//  TEDTalks
//
//  Created by Ekaterina Grishina on 24/11/22.
//

import Foundation

final class VideosRequest: IDataRequestConvertable {

    typealias Response = [Video]
    
    var scheme: String {
        "https"
    }
    
    var host: String {
        "youtube.googleapis.com/youtube/v3"
    }
    
    var path: String {
        "search"
    }
    
    var method: RequestMethod {
        .get
    }
    
    var headers: [String : String]? { nil }
    var body: [String : String]? { return nil }
    
    func parameters() -> [String: Any]? {
        return  [
            "key": Environment.API_KEY,
            "channelId": ""
        ]
    }
}
