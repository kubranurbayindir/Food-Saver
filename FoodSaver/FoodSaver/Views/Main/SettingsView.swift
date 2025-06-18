//
//  SettingsView.swift
//  FoodSaver
//
//  Created by Kübra Nur Bayındır on 22.10.2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Görünüm")) {
                    Toggle(isOn: $isDarkMode) {
                        HStack {
                            Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                                .foregroundColor(isDarkMode ? .purple : .orange)
                            Text("Karanlık Mod")
                        }
                    }
                }
                
                Section(header: Text("Uygulama Bilgileri")) {
                    HStack {
                        Text("Toplam Tarif")
                        Spacer()
                        Text("\(recipeViewModel.recipes.count)")
                            .foregroundColor(.gray)
                    }
                }
                
                Section(header: Text("Veri Yönetimi")) {
                    Button(action: {
                        showingAlert = true
                    }) {
                        HStack {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                            Text("Tüm Tarifleri Sil")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                Section(header: Text("Hakkında")) {
                    HStack {
                        Text("Versiyon")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Geliştirici")
                        Spacer()
                        Text("Kübra Nur Bayındır")
                            .foregroundColor(.gray)
                    }
                }
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
