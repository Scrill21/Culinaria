//
//  RecipesViewModel.swift
//  Culinaria
//
//  Created by anthony byrd on 5/13/25.
//

import Foundation

class RecipesViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    @Published var errorMessage: String?
    
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
            errorMessage = networkingError.customDescription
        }
    }
}
