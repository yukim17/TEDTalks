//
//  IDataRequestConvertible.swift
//  TEDTalks
//
//  Created by Ekaterina Grishina on 24/11/22.
//

import Foundation

protocol IDataRequestConvertable: IDataRequest {
    
    func asUrlRequest() -> URLRequest?
}

extension IDataRequestConvertable {
    
    func asUrlRequest() -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        urlComponents.path = self.path
        
        let params = self.parameters()
        urlComponents.queryItems = params.map { (item) -> URLQueryItem in
            return URLQueryItem(name: item.key, value: "\(item.value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.allHTTPHeaderFields = self.headers
        
        if let body = self.body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        return urlRequest
    }
}
