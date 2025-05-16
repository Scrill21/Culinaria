//
//  RecipesViewModelTests.swift
//  CulinariaTests
//
//  Created by anthony byrd on 5/15/25.
//

import XCTest
@testable import Culinaria

class RecipesViewModelTests: XCTestCase {
    
    func test_RecipesViewModel_init_shouldBeInitialized() {
        // Given
        let service = MockRecipeDataService()
        let viewModel = RecipesViewModel(service: service)
        
        // Then
        XCTAssertNotNil(viewModel, "RecipesViewModel should not be nil")
    }
    
    func test_RecipesViewModel_fetchData_isSuccessful() async {
        // Given
        let service = MockRecipeDataService()
        let viewModel = RecipesViewModel(service: service)
        
        // When
        await viewModel.fetchRecipes()
        
        // Then
        XCTAssertNil(viewModel.errorMessage)
        XCTAssert(viewModel.recipes.count > 0, "Checks if recipes array has recipes")
        XCTAssertEqual(viewModel.recipes.count, 63, "Checks if all recipes have been parsed")
    }
    
    func test_RecipesViewModel_fetchData_failedWithMalformedMockData() async {
        // Given
        let service = MockRecipeDataService()
        
        // When
        service.mockData = mockRecipeData_invalidJSON
        let viewModel = RecipesViewModel(service: service)
        
        await viewModel.fetchRecipes()
        
        // Then
        XCTAssertTrue(viewModel.recipes.isEmpty, "Checks that recipes array does not contain recipes")
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, "An unknown error occurred: The data couldn’t be read because it is missing.")
    }
    
    func test_RecipesViewModel_fetchData_emptyRecipesMockData() async {
        // Given
        let service = MockRecipeDataService()
        
        // When
        service.mockData = mockRecipeData_emptyRecipes
        let viewModel = RecipesViewModel(service: service)
        
        await viewModel.fetchRecipes()
        
        // Then
        XCTAssertNil(viewModel.errorMessage)
        XCTAssert(viewModel.recipes.isEmpty)
    }
    
    func test_RecipesViewModel_errorMessage_invalidURL() async {
        // Given
        let service = MockRecipeDataService()
        
        // When
        service.mockError = .invalidURL
        let viewModel = RecipesViewModel(service: service)
        
        await viewModel.fetchRecipes()
        
        // Then
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, NetworkingError.invalidURL.customDescription, "Invalid URL")
    }
    
    func test_RecipesViewModel_errorMessage_invalidData() async {
        // Given
        let service = MockRecipeDataService()
        
        // When
        service.mockError = .invalidData
        let viewModel = RecipesViewModel(service: service)
        
        await viewModel.fetchRecipes()
        
        // Then
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, NetworkingError.invalidData.customDescription, "Invalid data")
    }
    
    func test_RecipesViewModel_errorMessage_failedRequest() async {
        // Given
        let service = MockRecipeDataService()
        
        // When
        service.mockError = .requestFailed
        let viewModel = RecipesViewModel(service: service)
        
        await viewModel.fetchRecipes()
        
        // Then
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, NetworkingError.requestFailed.customDescription, "Request to server failed")
    }
    
    func test_RecipesViewModel_errorMessage_invalidStatusCode() async {
        // Given
        let service = MockRecipeDataService()
        
        // When
        service.mockError = .invalidStatusCode(statusCode: 404)
        let viewModel = RecipesViewModel(service: service)
        
        await viewModel.fetchRecipes()
        
        // Then
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage,
                       NetworkingError.invalidStatusCode(statusCode: 404).customDescription, "Failed with status code: 404")
    }
    
    func test_RecipesViewModel_errorMessage_jsonParsingFailure() async {
        // Given
        let service = MockRecipeDataService()
        
        // When
        service.mockError = .jsonParsingFailure(description: "The data couldn’t be read because it is missing.")
        let viewModel = RecipesViewModel(service: service)
        
        await viewModel.fetchRecipes()
        
        // Then
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage,
                       NetworkingError.jsonParsingFailure(description: "The data couldn’t be read because it is missing.").customDescription,
                       "Failed to parse JSON: The data couldn’t be read because it is missing.")
    }
}
