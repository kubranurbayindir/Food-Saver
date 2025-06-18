import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if recipeViewModel.favoriteRecipes.isEmpty {
                    // Favori tarif yoksa gösterilecek görünüm
                    VStack(spacing: 20) {
                        Image(systemName: "heart.slash")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("Henüz favori tarifin yok")
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        Text("Tarifleri görüntülerken kalp ikonuna tıklayarak favorilerine ekleyebilirsin")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                } else {
                    // Favori tarifler varsa gösterilecek liste
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(recipeViewModel.recipes.filter { recipeViewModel.favoriteRecipes.contains($0.id) }) { recipe in
                                NavigationLink(destination: RecipeView(recipe: recipe)) {
                                    RecipeCard(recipe: recipe)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Favori Tariflerim")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(RecipeViewModel())
    }
} 