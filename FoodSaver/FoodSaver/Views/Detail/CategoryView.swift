//
//  CategoryView.swift
//  FoodSaver
//
//  Created by Kübra Nur Bayındır on 22.10.2024.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    let category: Category
    
    private var recipes: [Recipe] {
        recipeViewModel.recipes.filter { $0.category == category.rawValue }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            if recipes.isEmpty {
                Text("Bu kategoride henüz tarif bulunmuyor")
                    .foregroundColor(.gray)
                    .padding(.top, 50)
            } else {
                RecipeList(recipes: recipes)
                    .padding(.vertical)
            }
        }
        .navigationTitle(category.rawValue)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryView(category: .dessert)
                .environmentObject(RecipeViewModel())
        }
    }
} 
