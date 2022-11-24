//
//  NetworkService.swift
//  TEDTalks
//
//  Created by Ekaterina Grishina on 24/11/22.
//

import Foundation
import Combine

protocol INetworkService: AnyObject {
    
    func executeRequest<R>(_ request: R) -> AnyPublisher<R.Response, NetworkError> where R: IDataRequestConvertable
}

final class DefaultNetworkService: INetworkService {
    
    public static let shared = DefaultNetworkService()
    
    private let session: URLSession
    private let configuration: URLSessionConfiguration
    
    init(configuration: URLSessionConfiguration = .default) {
        self.configuration = configuration
        self.session = URLSession(configuration: configuration)
    }
    
    func executeRequest<R>(_ request: R) -> AnyPublisher<R.Response, NetworkError> where R: IDataRequestConvertable {
        
        guard let urlRequest = request.asUrlRequest() else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { (data, response) -> Data in
                if let httpResponse = response as? HTTPURLResponse {
                    if (200...399).contains(httpResponse.statusCode) {
                        return data
                    }
                    throw NetworkError.httpError
                } else {
                    throw NetworkError.invalidResponse
                }
            }
            .tryMap { data in
                do {
                    return try request.decode(data)
                } catch {
                    throw NetworkError.decode
                }
            }
            .mapError { error in
                if let error = error as? NetworkError {
                    return error
                } else {
                    return NetworkError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
}
