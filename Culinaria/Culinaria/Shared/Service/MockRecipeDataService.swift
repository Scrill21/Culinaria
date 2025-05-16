//
//  MockRecipeDataService.swift
//  Culinaria
//
//  Created by anthony byrd on 5/15/25.
//

import Foundation

class MockRecipeDataService: RecipeDataServiceable {
    var mockData: Data?
    var mockError: NetworkingError?
    
    func fetchRecipes() async throws -> [Recipe] {
        if let mockError { throw mockError }
        
        do {
            let recipeResult = try JSONDecoder().decode(RecipeResult.self, from: mockData ?? mockRecipeData_validJSON)
            return recipeResult.recipes
        } catch {
            throw error as? NetworkingError ?? .unknownError(error: error)
        }
    }
}
