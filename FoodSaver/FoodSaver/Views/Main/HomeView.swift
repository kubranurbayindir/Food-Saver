//
//  HomeView.swift
//  FoodSaver
//
//  Created by Kübra Nur Bayındır on 12.10.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    RecipeList(recipes: recipeViewModel.recipes)
                }
                .padding(.vertical)
            }
            .navigationTitle("Kübra Nur'un Tarifleri")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(RecipeViewModel())
        }
    }
}
