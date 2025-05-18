//
//  CulinariaTests.swift
//  CulinariaTests
//
//  Created by anthony byrd on 5/15/25.
//

import XCTest
@testable import Culinaria

final class CulinariaTests: XCTestCase {
    func test_MockRecipeData_validJSON_isSuccessful() throws {
        do {
            let recipeResult = try JSONDecoder().decode(RecipeResult.self, from: mockRecipeData_validJSON)
            let recipes = recipeResult.recipes
            
            XCTAssert(recipes.count > 0, "Checks if recipes array has recipes")
            XCTAssert(recipes.count == 63, "Checks if all recipes have been parsed")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    // TODO: - Implement tests for MockMalformedRecipeData and MockEmptyRecipeData below:
}
