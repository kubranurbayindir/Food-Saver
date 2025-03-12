//
//  FavoritesView.swift
//  FoodSaver
//  favorileri sunack
//  Created by Kübra Nur Bayındır on 22.10.2024.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if recipeViewModel.favoritedRecipes.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "heart.slash")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("Henüz favori tarifin yok")
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        Text("Tarifleri görüntülerken kalp ikonuna tıklayarak favorilerine ekleyebilirsin")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                } else {
                    ScrollView {
                        RecipeList(recipes: recipeViewModel.favoritedRecipes)
                    }
                }
            }
            .navigationTitle("Favori Tariflerim")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(RecipeViewModel())
    }
}
