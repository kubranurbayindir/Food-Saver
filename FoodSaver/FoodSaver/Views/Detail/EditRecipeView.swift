import SwiftUI

struct EditRecipeView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    @State private var name: String
    @State private var category: String
    @State private var description: String
    @State private var ingredients: String
    @State private var directions: String
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    
    let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
        _name = State(initialValue: recipe.name)
        _category = State(initialValue: recipe.category)
        _description = State(initialValue: recipe.description)
        _ingredients = State(initialValue: recipe.ingredients)
        _directions = State(initialValue: recipe.directions)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Tarif Bilgileri")) {
                    TextField("Tarif Adı", text: $name)
                    TextField("Kategori", text: $category)
                    TextEditor(text: $description)
                        .frame(height: 100)
                }
                
                Section(header: Text("Malzemeler")) {
                    TextEditor(text: $ingredients)
                        .frame(height: 150)
                }
                
                Section(header: Text("Hazırlanışı")) {
                    TextEditor(text: $directions)
                        .frame(height: 150)
                }
                
                Section(header: Text("Fotoğraf")) {
                    Button(action: {
                        showImagePicker = true
                    }) {
                        Text("Fotoğraf Seç")
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
        }
    }
    
    private func saveRecipe() {
        var updatedRecipe = recipe
        updatedRecipe.name = name
        updatedRecipe.category = category
        updatedRecipe.description = description
        updatedRecipe.ingredients = ingredients
        updatedRecipe.directions = directions
        
        if let newImage = selectedImage {
            let imageName = recipeViewModel.saveImage(image: newImage)
            if let imageName = imageName {
                updatedRecipe.image = imageName
            }
        }
        
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