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
                Text(recipe.name)
                    .font(.headline)
            }
            .navigationTitle("Culinaria")
        }
    }
}

#Preview {
    RecipesView(viewModel: RecipesViewModel())
}
