//
//  RecipeView.swift
//  FoodSaver
//
//  Created by Kübra Nur Bayındır on 22.10.2024.
//

import SwiftUI

struct RecipeView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @State private var showingEditSheet = false
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Resim
                if let image = recipeViewModel.loadImage(name: recipe.image) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                        .clipped()
                } else {
                    Image(recipe.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                        .clipped()
                }
                
                VStack(alignment: .leading, spacing: 30) {
                    // Başlık ve Kategori
                    VStack(alignment: .center, spacing: 12) {
                        Text(recipe.name)
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .bold()
                        
                        HStack(spacing: 8) {
                            Image(systemName: "tag.fill")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                            
                            Text(recipe.category)
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    // Açıklama
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Tarif Hakkında")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(recipe.description)
                            .multilineTextAlignment(.leading)
                    }
                    
                    // Malzemeler
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Malzemeler")
                            .font(.headline)
                        Text(recipe.ingredients)
                            .multilineTextAlignment(.leading)
                    }
                    
                    // Hazırlanışı
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Hazırlanışı")
                            .font(.headline)
                        Text(recipe.directions)
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(.horizontal)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button(action: {
                        recipeViewModel.toggleFavorite(for: recipe)
                    }) {
                        Image(systemName: recipeViewModel.isFavorite(recipe) ? "heart.fill" : "heart")
                            .foregroundColor(recipeViewModel.isFavorite(recipe) ? .red : .gray)
                    }
                    
                    Button(action: {
                        showingEditSheet = true
                    }) {
                        Image(systemName: "pencil")
                    }
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            EditRecipeView(recipe: recipe)
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipeView(recipe: Recipe.all[0])
                .environmentObject(RecipeViewModel())
        }
    }
} 
