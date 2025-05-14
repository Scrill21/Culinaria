//
//  NetworkingError.swift
//  Culinaria
//
//  Created by anthony byrd on 5/13/25.
//

import Foundation

enum NetworkingError: Error {
    case invalidURL
    case invalidData
    case requestFailed
    case invalidStatusCode(statusCode: Int)
    case jsonParsingFailure(description: String)
    case unknownError(error: Error)
    
    var customDescription: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidData: return "Invalid data"
        case .requestFailed: return "Request to server failed"
        case let .invalidStatusCode(statusCode): return "Failed with status code: \(statusCode)"
        case let .jsonParsingFailure(description): return "Failed to parse JSON: \(description)"
        case let .unknownError(error): return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}
