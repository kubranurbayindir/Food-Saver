//
//  SettingsView.swift
//  FoodSaver
//
//  Created by Kübra Nur Bayındır on 22.10.2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // Ayarlar listesi buraya gelecek
                    Group {
                        HStack {
                            Text("Toplam Tarif")
                            Spacer()
                            Text("\(recipeViewModel.recipes.count)")
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            Text("Uygulama Versiyonu")
                            Spacer()
                            Text("1.0.0")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Ayarlar")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(RecipeViewModel())
    }
}
