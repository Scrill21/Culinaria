//
//  RecipesViewModel.swift
//  Culinaria
//
//  Created by anthony byrd on 5/13/25.
//

import Foundation

class RecipesViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    @Published var selectedCuisineType: CuisineOptions = .all
    @Published var isErrorPresented: Bool = false
    
    var errorMessage: String?
    
    var cuisineType: [Recipe] {
        switch selectedCuisineType {
            
        case .all:
            return recipes
        case .american:
            return recipes.filter { $0.cuisine == "American" }
        case .british:
            return recipes.filter { $0.cuisine == "British" }
        case .canadian:
            return recipes.filter { $0.cuisine == "Canadian" }
        case .croatian:
            return recipes.filter { $0.cuisine == "Croatian" }
        case .french:
            return recipes.filter { $0.cuisine == "French" }
        case .greek:
            return recipes.filter { $0.cuisine == "Greek" }
        case .italian:
            return recipes.filter { $0.cuisine == "Italian" }
        case .malaysian:
            return recipes.filter { $0.cuisine == "Malaysian" }
        case .polish:
            return recipes.filter { $0.cuisine == "Polish" }
        case .portuguese:
            return recipes.filter { $0.cuisine == "Portuguese" }
        case .russian:
            return recipes.filter { $0.cuisine == "Russian" }
        case .tunisian:
            return recipes.filter { $0.cuisine == "Tunisian" }
        }
    }
    
    private let service: RecipeDataServiceable
    
    init(service: RecipeDataServiceable) {
        self.service = service
    }
    
    @MainActor
    func fetchRecipes() async {
        do {
            recipes = try await service.fetchRecipes()
        } catch {
            guard let networkingError = error as? NetworkingError else { return }
            isErrorPresented = true
            errorMessage = networkingError.customDescription
        }
    }
}
