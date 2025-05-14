//
//  RecipeDataService.swift
//  Culinaria
//
//  Created by anthony byrd on 5/13/25.
//

import Foundation

class RecipeDataService {
    
    func fetchRecipes() async throws -> [Recipe] {
        let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        guard let url = URL(string: urlString) else {
            throw APIError.requestFailed(description: "Bad URL")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed(description: "Failed to get a response from the server")
        }
        
        guard httpResponse.statusCode == 200 else {
            throw APIError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        do {
            let recipeResult = try JSONDecoder().decode(RecipeResult.self, from: data)
            return recipeResult.recipes
        } catch {
            throw APIError.jsonParsingFailure
        }
    }
}
