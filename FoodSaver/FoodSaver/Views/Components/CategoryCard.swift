//
//  CategoryCard.swift
//  FoodSaver
//
//  Created by Kübra Nur Bayındır on 22.10.2024.
//

import SwiftUI

struct CategoryCard: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    let category: Category
    
    private var recipeCount: Int {
        recipeViewModel.recipes.filter { $0.category == category.rawValue }.count
    }
    
    private var categoryIcon: String {
        switch category {
        case .breakfast: return "☀️"
        case .soup: return "🥣"
        case .salad: return "🥗"
        case .appetizer: return "🍱"
        case .dessert: return "🍰"
        case .snack: return "🥨"
        case .drink: return "🥤"
        }
    }
    
    private var backgroundColor: Color {
        switch category {
        case .breakfast: return Color.orange.opacity(0.2)
        case .soup: return Color.red.opacity(0.2)
        case .salad: return Color.green.opacity(0.2)
        case .appetizer: return Color.purple.opacity(0.2)
        case .dessert: return Color.pink.opacity(0.2)
        case .snack: return Color.yellow.opacity(0.2)
        case .drink: return Color.blue.opacity(0.2)
        }
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Text(categoryIcon)
                .font(.system(size: 40))
            
            Text(category.rawValue)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("\(recipeCount) Tarif")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 160)
        .background(backgroundColor)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

struct CategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCard(category: .breakfast)
            .environmentObject(RecipeViewModel())
            .padding()
    }
} 
