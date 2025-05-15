//
//  RecipeDataService.swift
//  Culinaria
//
//  Created by anthony byrd on 5/13/25.
//

import Foundation

protocol RecipeDataServiceable {
    func fetchRecipes() async throws -> [Recipe]
}

class RecipeDataService: RecipeDataServiceable, HTTPSDataDownloader {
    private var baseURLComponents: URLComponents {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "d3jbb8n5wk0qxi.cloudfront.net"
        
        return components
    }
    
    private var recipesURLString: String? {
        var components = baseURLComponents
        
        components.path += "/recipes.json"
        
        return components.url?.absoluteString
    }
    
    private var malformedRecipesURLString: String? {
        var components = baseURLComponents
        
        components.path += "/recipes-malformed.json"
        
        return components.url?.absoluteString
    }
    
    private var emptyRecipesURLString: String? {
        var components = baseURLComponents
        
        components.path += "recipes-empty.json"
        
        return components.url?.absoluteString
    }
    
    /*
     https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json
     https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json
     https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json
     */
    
    func fetchRecipes() async throws -> [Recipe] {
        guard let endpoint = recipesURLString else {
            throw NetworkingError.invalidURL
        }
        
        let recipeResult = try await fetchData(as: RecipeResult.self, endpoint: endpoint)
        
        return recipeResult.recipes
    }
}

//MARK: - Fetch request implementation without modularization

extension RecipeDataService {
    private func fetchRecipesWithoutModularization() async throws -> [Recipe] {
        let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        
        guard let url = URL(string: urlString) else {
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
            let recipeResult = try JSONDecoder().decode(RecipeResult.self, from: data)
            return recipeResult.recipes
        } catch {
            throw NetworkingError.jsonParsingFailure(description: error.localizedDescription)
        }
    }
}
