//
//  RecipesView.swift
//  Culinaria
//
//  Created by anthony byrd on 5/13/25.
//

import SwiftUI

struct RecipesView: View {
    @StateObject var viewModel: RecipesViewModel
    @State private var isShowingAlert = false
    
    init(service: RecipeDataServiceable) {
        self._viewModel = StateObject(wrappedValue: RecipesViewModel(service: service))
    }
    
    var body: some View {
        NavigationStack {
            
            HStack {
                Text("Recipes")
                    .font(.title2)
                    .padding()
                
                Spacer()
                
                Menu {
                    
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(.black)
                        .padding()
                }
            }
            
            
            List(viewModel.recipes) { recipe in
                NavigationLink(value: recipe) {
                    RecipeView(name: recipe.name,
                               cuisine: recipe.cuisine,
                               smallPhotoURLString: recipe.photoURLSmall)
                }
            }
            .navigationDestination(for: Recipe.self, destination: { recipe in
                RecipeDetailsView(viewModel: RecipeDetailsViewModel(recipe: recipe))
            })
            .navigationTitle("Culinaria")
            .overlay {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .padding()
                }
            }
        }
        .task {
            await viewModel.fetchRecipes()
        }
    }
}

#Preview {
    RecipesView(service: MockRecipeDataService())
}

struct RecipeView: View {
    let name: String
    let cuisine: String
    let smallPhotoURLString: String
    
    var body: some View {
        HStack(spacing: 10) {
            ImageView(urlString: smallPhotoURLString)
                .frame(width: 75, height: 75)
                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                .scaledToFill()
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                
                Text(cuisine)
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
        }
    }
}
