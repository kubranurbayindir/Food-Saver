//
//  RecipeViewModel.swift
//  FoodSaver
//
//  Created by Kübra Nur Bayındır on 22.10.2024.
//

import SwiftUI

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var favoriteRecipes: Set<UUID> = []
    
    init() {
        // Başlangıçta var olan tarifleri yükle
        loadRecipes()
        loadFavorites()
    }
    
    private func loadRecipes() {
        // UserDefaults'tan kayıtlı tarifleri yükle
        if let savedRecipes = UserDefaults.standard.data(forKey: "savedRecipes"),
           let decodedRecipes = try? JSONDecoder().decode([Recipe].self, from: savedRecipes) {
            recipes = decodedRecipes
        } else {
            // Eğer kayıtlı tarif yoksa varsayılan tarifleri yükle
            recipes = Recipe.all
        }
    }
    
    private func saveRecipesToStorage() {
        // Tarifleri UserDefaults'a kaydet
        if let encoded = try? JSONEncoder().encode(recipes) {
            UserDefaults.standard.set(encoded, forKey: "savedRecipes")
        }
    }
    
    func addRecipe(name: String, category: Category, description: String, ingredients: String, directions: String, image: UIImage?) {
        // Resmi kaydet ve adını al
        let imageName = saveImage(image: image)
        
        // Yeni tarifi oluştur
        let newRecipe = Recipe(
            name: name,
            image: imageName ?? "defaultRecipeImage",
            description: description,
            ingredients: ingredients,
            directions: directions,
            category: category.rawValue,
            datePublished: getCurrentDate()
        )
        
        // Tariflere ekle
        recipes.append(newRecipe)
        
        // Değişiklikleri kaydet
        saveRecipesToStorage()
    }
    
    // Resmi kaydetmek için yardımcı fonksiyon
    func saveImage(image: UIImage?) -> String? {
        guard let image = image,
              let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        
        let imageName = UUID().uuidString
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imageUrl = documentsDirectory.appendingPathComponent("\(imageName).jpg")
        
        do {
            try data.write(to: imageUrl)
            return imageName
        } catch {
            print("Image kaydetme hatası: \(error)")
            return nil
        }
    }
    
    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
    
    // Resmi yüklemek için yardımcı fonksiyon
    func loadImage(name: String) -> UIImage? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imageUrl = documentsDirectory.appendingPathComponent("\(name).jpg")
        
        do {
            let imageData = try Data(contentsOf: imageUrl)
            return UIImage(data: imageData)
        } catch {
            print("Image yükleme hatası: \(error)")
            return nil
        }
    }
    
    func updateRecipe(_ updatedRecipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == updatedRecipe.id }) {
            recipes[index] = updatedRecipe
            saveRecipesToStorage()
        }
    }
    
    private func loadFavorites() {
        if let savedFavorites = UserDefaults.standard.array(forKey: "favoriteRecipes") as? [String] {
            favoriteRecipes = Set(savedFavorites.compactMap { UUID(uuidString: $0) })
        }
    }
    
    private func saveFavorites() {
        let favoriteIds = favoriteRecipes.map { $0.uuidString }
        UserDefaults.standard.set(favoriteIds, forKey: "favoriteRecipes")
    }
    
    func toggleFavorite(for recipe: Recipe) {
        if favoriteRecipes.contains(recipe.id) {
            favoriteRecipes.remove(recipe.id)
        } else {
            favoriteRecipes.insert(recipe.id)
        }
        saveFavorites()
    }
    
    func isFavorite(_ recipe: Recipe) -> Bool {
        favoriteRecipes.contains(recipe.id)
    }
    
    var favoritedRecipes: [Recipe] {
        recipes.filter { favoriteRecipes.contains($0.id) }
    }
} 
