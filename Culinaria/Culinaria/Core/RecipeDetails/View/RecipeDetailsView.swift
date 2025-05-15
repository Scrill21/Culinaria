//
//  RecipeDetailsView.swift
//  Culinaria
//
//  Created by anthony byrd on 5/13/25.
//

import SwiftUI

struct RecipeDetailsView: View {
    @StateObject var viewModel: RecipeDetailsViewModel
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .mint, location: 0.3),
                .init(color: .white, location: 0.3)
            ], center: .bottom, startRadius: 700, endRadius: 10)
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.name)
                            .font(.largeTitle)
                            .bold()
                        
                        Text(viewModel.cuisine)
                            .font(.headline)
                            .fontWeight(.light)
                    }
                    .padding()
                    
                    Spacer()
                }
                
                HStack(alignment: .center) {
                    HStack {
                        Image(systemName: "safari")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFit()
                        
                        Text("Recipe Site")
                            .font(.headline)
                    }
                    
                    Divider()
                        .frame(width: 2, height: 35)
                        .overlay(.mint)
                    
                    HStack {
                        Image("youtube")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFit()
                        
                        Text("Youtube")
                            .font(.headline)
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeDetailsView(viewModel: RecipeDetailsViewModel(recipe: RecipeDetailsViewModel.previewRecipe))
}
