//
//  TestDataTests.swift
//  TestDataTests
//
//  Created by anthony byrd on 5/15/25.
//

import XCTest
@testable import Culinaria

final class TestDataTests: XCTestCase {
    func test_MockRecipeData_validJSON_isSuccessful() throws {
        do {
            let recipeResult = try JSONDecoder().decode(RecipeResult.self, from: mockRecipeData_validJSON)
            let recipes = recipeResult.recipes
            
            XCTAssert(recipes.count > 0, "Verifies that the recipes array has recipes")
            XCTAssert(recipes.count == 63, "Verifies that all recipes have been parsed")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_MockRecipeData_invalidJSON_failsWithError() throws {
        do {
            let _ = try JSONDecoder().decode(RecipeResult.self, from: mockRecipeData_invalidJSON)
            
            XCTFail("This line of code should never be executed")
        } catch {
            XCTAssert(error.localizedDescription == "The data couldn’t be read because it is missing.")
        }
    }
    
    func test_MockRecipeData_emptyRecipes_isTrue() {
        do {
            let recipeResult = try JSONDecoder().decode(RecipeResult.self, from: mockRecipeData_emptyRecipes)
            let recipes = recipeResult.recipes
            
            XCTAssertTrue(recipes.isEmpty, "Verifies that the recipes array is empty")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
