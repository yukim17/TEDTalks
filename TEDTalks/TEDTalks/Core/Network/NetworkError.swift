//
//  NetworkError.swift
//  TEDTalks
//
//  Created by Ekaterina Grishina on 24/11/22.
//

import Foundation

enum NetworkError: Error {
    case decode
    case invalidURL
    case invalidResponse
    case httpError
    case unknown
}
