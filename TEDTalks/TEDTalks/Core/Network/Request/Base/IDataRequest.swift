//
//  DataRequest.swift
//  TEDTalks
//
//  Created by Ekaterina Grishina on 24/11/22.
//

import Foundation

protocol IDataRequest {
    
    associatedtype Response: Decodable
    
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var headers: [String: String]? { get }
    var body: [String: String]? { get }
    
    func parameters() -> [String: Any]
    func decode(_ data: Data) throws -> Response
}

extension IDataRequest where Response: Decodable {
    
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}

extension IDataRequest {
    var headers: [String: String] {
        [:]
    }
    
    var body: [String: String] {
        [:]
    }
    
    func parameters() -> [String: Any] {
        return  [:]
    }
}
