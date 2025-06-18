import SwiftUI
import PhotosUI

struct EditRecipeView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    @State private var name: String
    @State private var selectedCategory: Category
    @State private var description: String
    @State private var ingredients: String
    @State private var directions: String
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
        _name = State(initialValue: recipe.name)
        _selectedCategory = State(initialValue: Category(rawValue: recipe.category) ?? .breakfast)
        _description = State(initialValue: recipe.description)
        _ingredients = State(initialValue: recipe.ingredients)
        _directions = State(initialValue: recipe.directions)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Tarif Bilgileri")) {
                    TextField("Tarif Adı", text: $name)
                    
                    Picker("Kategori", selection: $selectedCategory) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Text(category.rawValue)
                                .tag(category)
                        }
                    }
                    
                    ZStack(alignment: .leading) {
                        if description.isEmpty {
                            Text("Tarif Açıklaması")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 4)
                        }
                        TextEditor(text: $description)
                            .frame(height: 100)
                    }
                }
                
                Section(header: Text("Malzemeler")) {
                    ZStack(alignment: .leading) {
                        if ingredients.isEmpty {
                            Text("Malzemeleri buraya yazın")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 4)
                        }
                        TextEditor(text: $ingredients)
                            .frame(height: 150)
                    }
                }
                
                Section(header: Text("Hazırlanışı")) {
                    ZStack(alignment: .leading) {
                        if directions.isEmpty {
                            Text("Hazırlanış adımlarını buraya yazın")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 4)
                        }
                        TextEditor(text: $directions)
                            .frame(height: 150)
                    }
                }
                
                Section(header: Text("Fotoğraf")) {
                    Button(action: {
                        showImagePicker = true
                    }) {
                        HStack {
                            Image(systemName: "photo")
                            Text("Fotoğraf Seç")
                        }
                    }
                    
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    } else if let image = recipeViewModel.loadImage(name: recipe.image) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                }
            }
            .navigationTitle("Tarifi Düzenle")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kaydet") {
                        saveRecipe()
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedImage)
            }
            .alert("Uyarı", isPresented: $showAlert) {
                Button("Tamam", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func saveRecipe() {
        // Validasyon kontrolleri
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            alertMessage = "Lütfen tarif adını giriniz"
            showAlert = true
            return
        }
        
        guard !ingredients.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            alertMessage = "Lütfen malzemeleri giriniz"
            showAlert = true
            return
        }
        
        guard !directions.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            alertMessage = "Lütfen hazırlanış adımlarını giriniz"
            showAlert = true
            return
        }
        
        // Tarifi güncelle
        var updatedRecipe = recipe
        updatedRecipe.name = name
        updatedRecipe.category = selectedCategory.rawValue
        updatedRecipe.description = description
        updatedRecipe.ingredients = ingredients
        updatedRecipe.directions = directions
        
        // Yeni resim seçildiyse kaydet
        if let newImage = selectedImage {
            if let imageName = recipeViewModel.saveImage(image: newImage) {
                updatedRecipe.image = imageName
            }
        }
        
        // Tarifi kaydet ve sayfayı kapat
        recipeViewModel.updateRecipe(updatedRecipe)
        dismiss()
    }
}

struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeView(recipe: Recipe.all[0])
            .environmentObject(RecipeViewModel())
    }
} 
