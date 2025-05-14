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
        guard let url = URL(string: urlString) else { return [] }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return []
        }
        
        guard httpResponse.statusCode == 200 else {
            return []
        }
        
        do {
            let recipeResult = try JSONDecoder().decode(RecipeResult.self, from: data)
            return recipeResult.recipes
        } catch {
            return []
        }
    }
}
