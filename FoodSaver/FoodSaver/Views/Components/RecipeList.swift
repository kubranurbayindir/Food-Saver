//
//  RecipeList.swift
//  FoodSaver
//
//  Created by Kübra Nur Bayındır on 22.10.2024.
//

import SwiftUI

struct RecipeList: View {
    let recipes: [Recipe]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)], spacing: 15) {
            ForEach(recipes) { recipe in
                NavigationLink(destination: RecipeView(recipe: recipe)) {
                    RecipeCard(recipe: recipe)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrollView {
                RecipeList(recipes: Recipe.all)
            }
        }
        .environmentObject(RecipeViewModel())
    }
} 