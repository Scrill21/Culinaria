//
//  RecipeDetailsViewModel.swift
//  Culinaria
//
//  Created by anthony byrd on 5/13/25.
//

import Foundation

class RecipeDetailsViewModel: ObservableObject {
    let recipe: Recipe
    
    var cuisine: String {
        recipe.cuisine
    }
    
    var name: String {
        recipe.name
    }
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
}

extension RecipeDetailsViewModel {
    static let previewRecipe = Recipe(cuisine: "Malaysian",
                                      name: "Apam Balik",
                                      photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                                      photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                                      sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                                      id: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                                      youtubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
}
