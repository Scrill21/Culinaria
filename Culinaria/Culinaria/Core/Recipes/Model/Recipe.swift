//
//  Recipe.swift
//  Culinaria
//
//  Created by anthony byrd on 5/13/25.
//

import Foundation

struct RecipeResult: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable, Identifiable, Hashable {
    let cuisine: String
    let name: String
    let photoURLLarge: String
    let photoURLSmall: String
    let sourceUrl: String?
    let id: String
    let youtubeUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case cuisine, name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case id = "uuid"
        case youtubeUrl = "youtube_url"
    }
}
