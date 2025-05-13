//
//  Recipe.swift
//  Culinaria
//
//  Created by anthony byrd on 5/13/25.
//

import Foundation

struct Recipe: Decodable, Identifiable, Hashable {
    let cuisine: String
    let name: String
    let largeImage: String
    let smallImage: String
    let source: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case cuisine, name
        case largeImage = "photo_url_large"
        case smallImage = "photo_url_small"
        case source = "source_url"
        case id = "uuid"
    }
}
