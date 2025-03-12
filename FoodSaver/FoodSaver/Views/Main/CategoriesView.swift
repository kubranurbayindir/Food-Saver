//
//  CategoriesView.swift
//  FoodSaver
//  tarifleri kategoriler halinde sunacağımız ekran
//  Created by Kübra Nur Bayındır on 22.10.2024.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    private let categories: [Category] = Category.allCases
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 20) {
                    ForEach(categories, id: \.self) { category in
                        NavigationLink(destination: CategoryView(category: category)) {
                            CategoryCard(category: category)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Kategoriler")
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
            .environmentObject(RecipeViewModel())
    }
}
