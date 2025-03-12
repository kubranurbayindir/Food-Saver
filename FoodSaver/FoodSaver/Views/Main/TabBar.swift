//
//  TabBar.swift
//  FoodSaver
//
//  Created by Kübra Nur Bayındır on 15.10.2024.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            //sekme ögesinde bir metin ve simgeyi bir araya getirecez
            HomeView()
                .tabItem {
                    Label("Anasayfa", systemImage: "house")
                }
            
            CategoriesView()
                .tabItem {
                    Label("Kategori", systemImage: "square.fill.text.grid.1x2")
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
    }
}

#Preview {
    TabBar()
}
