//
//  HTTPSDataDownloader.swift
//  Culinaria
//
//  Created by anthony byrd on 5/13/25.
//

import Foundation

protocol HTTPSDataDownloader {
    func fetchData<T: Decodable>(as type: T.Type, endpoint: String) async throws -> T
}

extension HTTPSDataDownloader {
    func fetchData<T: Decodable>(as type: T.Type, endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw NetworkingError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkingError.requestFailed
        }
        
        guard httpResponse.statusCode == 200 else {
            throw NetworkingError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw NetworkingError.jsonParsingFailure(description: error.localizedDescription)
        }
    }
}
