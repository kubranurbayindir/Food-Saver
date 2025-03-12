//
//  ContentView.swift
//  FoodSaver
//
//  Created by Kübra Nur Bayındır on 12.10.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabBar()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RecipeViewModel())
    }
}
