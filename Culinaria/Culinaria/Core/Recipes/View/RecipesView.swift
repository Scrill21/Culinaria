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
                Spacer()
                
                Text("Choose cuisine:")
                    .font(.callout)
                
                Picker(selection: $viewModel.selectedCuisineType.animation()) {
                    ForEach(CuisineOptions.allCases, id: \.self) { cuisine in
                        Text(cuisine.type)
                    }
                } label: {
                    Text("selected filter:")
                }
            }
            
            List(viewModel.cuisineType) { recipe in
                NavigationLink(value: recipe) {
                    RecipeView(name: recipe.name,
                               cuisine: recipe.cuisine,
                               smallPhotoURLString: recipe.photoURLSmall)
                }
            }
            .navigationDestination(for: Recipe.self, destination: { recipe in
                RecipeDetailsView(viewModel: RecipeDetailsViewModel(recipe: recipe))
            })
            .refreshable {
                Task {
                    await viewModel.fetchRecipes()
                }
            }
            .navigationTitle("Culinaria")
            .alert("Ooops!, an error has occured", isPresented: $viewModel.isErrorPresented, actions: {
                Button("Cancel", role: .cancel) {}
                
                Button("Retry") {
                    viewModel.isErrorPresented = false
                    
                    Task {
                        await viewModel.fetchRecipes()
                    }
                }
            }, message: {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                }
            })
            .overlay {
                if viewModel.recipes.isEmpty {
                    ContentUnavailableView("No recipes", systemImage: "fork.knife.circle", description: Text("No recipes are currently available at this time."))
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
