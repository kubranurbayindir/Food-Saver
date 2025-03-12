//
//  RecipeModel.swift
//  FoodSaver
//
//  Created by Kübra Nur Bayındır on 15.10.2024.
//

import Foundation

enum Category: String, Codable, CaseIterable {
    case breakfast = "Kahvaltı"
    case soup = "Çorba"
    case salad = "Salata"
    case appetizer = "Meze"
    case dessert = "Tatlı"
    case snack = "Atıştırmalık"
    case drink = "İçecek"
}

struct Recipe: Identifiable, Codable {
    var id: UUID
    var name: String
    var image: String
    var description: String
    var ingredients: String
    var directions: String
    var category: String
    var datePublished: String
    
    init(id: UUID = UUID(), name: String, image: String, description: String, ingredients: String, directions: String, category: String, datePublished: String) {
        self.id = id
        self.name = name
        self.image = image
        self.description = description
        self.ingredients = ingredients
        self.directions = directions
        self.category = category
        self.datePublished = datePublished
    }
}

extension Recipe {
    static let all: [Recipe] = [
        Recipe(
            name: "Un Kurabiyesi",
            image: "un",
            description: "Nefis bir un kurabiyesi tarifi",
            ingredients: "2 su bardağı un\n1 su bardağı şeker\n125g tereyağı\n1 yumurta",
            directions: "1. Malzemeleri karıştırın\n2. Şekil verin\n3. 180 derecede pişirin",
            category: Category.dessert.rawValue,
            datePublished: "2024-10-10"
        ),
        Recipe(
            name: "Domates Çorbası",
            image: "un",
            description: "Sıcacık domates çorbası",
            ingredients: "5 domates\n1 soğan\n2 yemek kaşığı un\nTuz, karabiber",
            directions: "1. Domatesleri rendeleyin\n2. Soğanı kavurun\n3. Malzemeleri ekleyin",
            category: Category.soup.rawValue,
            datePublished: "2024-10-10"
        ),
        Recipe(
            name: "Yeşil Salata",
            image: "un",
            description: "Taze yeşil salata",
            ingredients: "Marul\nRoka\nMaydanoz\nZeytinyağı\nLimon",
            directions: "1. Yeşillikleri yıkayın\n2. Doğrayın\n3. Sosunu ekleyin",
            category: Category.salad.rawValue,
            datePublished: "2024-10-10"
        ),
        Recipe(
            name: "Havuç Tarator",
            image: "un",
            description: "Nefis havuç tarator",
            ingredients: "3 havuç\n2 diş sarımsak\nYoğurt\nZeytinyağı",
            directions: "1. Havuçları rendeleyin\n2. Sarımsağı ezin\n3. Malzemeleri karıştırın",
            category: Category.appetizer.rawValue,
            datePublished: "2024-10-10"
        ),
        Recipe(
            name: "Poğaça",
            image: "un",
            description: "Yumuşacık poğaça",
            ingredients: "3 su bardağı un\n1 paket yaş maya\nSüt\nTuz",
            directions: "1. Hamuru yoğurun\n2. Mayalandırın\n3. Şekil verip pişirin",
            category: Category.snack.rawValue,
            datePublished: "2024-10-10"
        ),
        Recipe(
            name: "Limonata",
            image: "un",
            description: "Ferahlatıcı limonata",
            ingredients: "5 limon\n1 su bardağı şeker\nNane\nSu",
            directions: "1. Limonları sıkın\n2. Şeker ekleyin\n3. Nane ile süsleyin",
            category: Category.drink.rawValue,
            datePublished: "2024-10-10"
        )
    ]
}
