//
//  RecipesView.swift
//  Culinaria
//
//  Created by anthony byrd on 5/13/25.
//

import SwiftUI

struct RecipesView: View {
    @StateObject var viewModel: RecipesViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.recipes) { recipe in
                NavigationLink(value: recipe) {
                    RecipeView(name: recipe.name,
                               cuisine: recipe.cuisine)
                }
            }
            .navigationDestination(for: Recipe.self, destination: { recipe in
                EmptyView()
            })
            .navigationTitle("Culinaria")
        }
    }
}

#Preview {
    RecipesView(viewModel: RecipesViewModel())
}

struct RecipeView: View {
    let name: String
    let cuisine: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "birthday.cake")
                .resizable()
                .frame(width: 50, height: 50)
            
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
