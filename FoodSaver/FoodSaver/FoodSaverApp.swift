//
//  FoodSaverApp.swift
//  FoodSaver
//
//  Created by Kübra Nur Bayındır on 12.10.2024.
//

import SwiftUI

@main
struct FoodSaverApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}

struct MainTabView: View {
    @StateObject private var recipeViewModel = RecipeViewModel()
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Tarifler", systemImage: "house")
                }
            
            CategoriesView()
                .tabItem {
                    Label("Kategoriler", systemImage: "square.grid.2x2")
                }
            
            NewRecipeView()
                .tabItem {
                    Label("Tarif Ekle", systemImage: "plus")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favoriler", systemImage: "heart")
                }
            
            SettingsView()
                .tabItem {
                    Label("Ayarlar", systemImage: "gear")
                }
        }
        .environmentObject(recipeViewModel)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static let recipeViewModel = RecipeViewModel()
    
    static var previews: some View {
        MainTabView()
    }
}
