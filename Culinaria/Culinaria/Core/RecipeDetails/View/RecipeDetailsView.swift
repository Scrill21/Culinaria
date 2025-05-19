//
//  RecipeDetailsView.swift
//  Culinaria
//
//  Created by anthony byrd on 5/13/25.
//

import SwiftUI

struct RecipeDetailsView: View {
    @Environment(\.openURL) var openURL
    @StateObject var viewModel: RecipeDetailsViewModel
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(.brandPrimary), location: 0.3),
                .init(color: .white, location: 0.3)
            ], center: .bottom, startRadius: 700, endRadius: 10)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                ImageView(urlString: viewModel.largePhotoURLString)
                    .frame(width: 300, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .scaledToFit()
                    .shadow(color: .black, radius: 15, y: 5)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.name)
                            .font(.largeTitle.bold())
                            .foregroundStyle(.black)
                        
                        Text(viewModel.cuisine)
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundStyle(.black)
                    }
                    .padding()
                    
                    Spacer()
                }
                
                HStack(alignment: .center) {
                    HStack {
                        if let sourceURL = viewModel.recipe.sourceUrl {
                            Button {
                                if let url = URL(string: sourceURL) {
                                    openURL(url)
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "safari")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .scaledToFit()
                                        .colorMultiply(.black)
                                    
                                    Text("Recipe Site")
                                        .font(.caption)
                                }
                            }.buttonStyle(.bordered)
                                .foregroundStyle(.black)
                                .tint(Color.brandPrimary)
                                .controlSize(.large)
                            
                            if viewModel.recipe.youtubeUrl != nil {
                                Divider()
                                    .frame(width: 2, height: 35)
                                    .overlay(Color(.gray))
                            }
                        }
                    }
                        
                    
                    HStack {
                        if let sourceURL = viewModel.recipe.youtubeUrl {
                            Button {
                                if let url = URL(string: sourceURL) {
                                    openURL(url)
                                }
                            } label: {
                                HStack {
                                    Image("youtube")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .scaledToFit()
                                    
                                    Text("Youtube")
                                        .font(.caption)
                                }
                            }
                            .buttonStyle(.bordered)
                            .foregroundStyle(.black)
                            .tint(Color.brandPrimary)
                            .controlSize(.large)
                        }
                    }
                }
                
                Spacer()
                Spacer()
            }
        }
    }
}

#Preview {
    RecipeDetailsView(viewModel: RecipeDetailsViewModel(recipe: RecipeDetailsViewModel.previewRecipe))
}
