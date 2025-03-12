//
//  NewRecipeView.swift
//  FoodSaver
//  kullanıcının yeni tarif eklemesini sağlayacak
//  Created by Kübra Nur Bayındır on 12.10.2024.
//

import SwiftUI

struct NewRecipeView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    // Form alanları için state değişkenleri
    @State private var name: String = ""
    @State private var selectedCategory: Category = .breakfast
    @State private var description: String = ""
    @State private var ingredients: String = ""
    @State private var directions: String = ""
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var showAlert = false
    
    // Tüm kategoriler
    let categories: [Category] = [.breakfast, .soup, .salad, .appetizer, .dessert, .snack, .drink]
    
    var body: some View {
        NavigationView {
            Form {
                // Fotoğraf Seçimi
                Section(header: Text("Tarif Fotoğrafı")) {
                    HStack {
                        Spacer()
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(10)
                        } else {
                            Image(systemName: "photo")
                                .font(.system(size: 80))
                                .foregroundColor(.gray)
                                .frame(height: 200)
                        }
                        Spacer()
                    }
                    .onTapGesture {
                        isImagePickerPresented.toggle()
                    }
                }
                
                // Temel Bilgiler
                Section(header: Text("Temel Bilgiler")) {
                    TextField("Tarif Adı", text: $name)
                    Picker("Kategori", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                }
                
                // Tarif Detayları
                Section(header: Text("Tarif Hakkında")) {
                    TextEditor(text: $description)
                        .frame(height: 100)
                }
                
                // Malzemeler
                Section(header: Text("Malzemeler")) {
                    TextEditor(text: $ingredients)
                        .frame(height: 150)
                }
                
                // Hazırlanışı
                Section(header: Text("Hazırlanışı")) {
                    TextEditor(text: $directions)
                        .frame(height: 200)
                }
            }
            .navigationTitle("Yeni Tarif")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kaydet") {
                        saveRecipe()
                    }
                    .disabled(name.isEmpty || description.isEmpty || ingredients.isEmpty || directions.isEmpty)
                }
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $selectedImage)
            }
            .alert("Tarif Kaydedildi", isPresented: $showAlert) {
                Button("Tamam") {
                    // Form alanlarını temizle
                    clearForm()
                }
            } message: {
                Text("Yeni tarifiniz başarıyla eklendi.")
            }
        }
    }
    
    private func saveRecipe() {
        recipeViewModel.addRecipe(
            name: name,
            category: selectedCategory,
            description: description,
            ingredients: ingredients,
            directions: directions,
            image: selectedImage
        )
        showAlert = true
    }
    
    private func clearForm() {
        name = ""
        selectedCategory = .breakfast
        description = ""
        ingredients = ""
        directions = ""
        selectedImage = nil
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView()
            .environmentObject(RecipeViewModel())
    }
}
