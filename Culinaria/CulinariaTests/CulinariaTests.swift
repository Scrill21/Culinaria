//
//  CulinariaTests.swift
//  CulinariaTests
//
//  Created by anthony byrd on 5/15/25.
//

import XCTest
@testable import Culinaria

final class CulinariaTests: XCTestCase {

    func test_mockRecipeData() throws {
        do {
            let recipeResult = try JSONDecoder().decode(RecipeResult.self, from: mockRecipeData_validJSON)
            let recipes = recipeResult.recipes
            
            XCTAssert(recipes.count > 0, "checks if recipes array has recipes")
            XCTAssert(recipes.count == 63, "checks if all recipes have been parsed")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
