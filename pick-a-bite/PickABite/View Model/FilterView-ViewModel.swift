//
//  MainView-ViewModel.swift
//  PickABite
//
//  Created by Abimanyu Damarjati on 09/04/25.
//

import SwiftUI

extension FilterView {
    @Observable
    class ViewModel {
        let foodCategoriesData: [FoodCategory] = [
            FoodCategory(key: "Coffee_Tea", name: "☕ Coffe Tea"),
            FoodCategory(key: "Sweet_Desserts", name: "🍰 Sweet Desserts"),
            FoodCategory(key: "Juice_Beverages", name: "🥤 Juice Beverages"),
            FoodCategory(key: "Healthy_Vegan", name: "🥗 Healthy Vegan"),
            FoodCategory(key: "Meat_Protein", name: "🥩 Meat Protein"),
            FoodCategory(key: "Seafood", name: "🦐 Seafood"),
            FoodCategory(key: "Spicy_Flavors", name: "🌶️ Spicy Flavorts"),
            FoodCategory(key: "Comfort_Food", name: "🍪 Comfort Food"),
            FoodCategory(key: "Noodles_Rice", name: "🍜 Noodles Rice"),
            FoodCategory(key: "Bakery_Bread", name: "🥖 Bakery Bread"),
            FoodCategory(key: "Hangout_Ambience", name: "🎨 Hangout Ambience"),
            FoodCategory(key: "Alcohol_Bar", name: "🍷 Alcohol Bar"),
            FoodCategory(key: "Snacks_Appetizers", name: "🍟 Snacks Appetizers"),
            FoodCategory(key: "Lunch_Meal", name: "🍱 Lunch Meal"),
            FoodCategory(key: "Soups_Broths", name: "🍲 Soups Broths"),
            FoodCategory(key: "Japanese_Cuisine", name: "🇯🇵 Japanese Cuisine"),
            FoodCategory(key: "Indonesian_Cuisine", name: "🇮🇩 Indonesian Cuisine"),
            FoodCategory(key: "Fast_Food", name: "🍔 Fast Food"),
            FoodCategory(key: "Refreshing_Fresh", name: "🥝 Refreshing Fresh"),
            FoodCategory(key: "Dining_Experience", name: "🍽️ Dining Experience"),
        ]
        
        private(set) var selected: Set<FoodCategory> = []
        
        func addOrRemoveSelected(_ category: FoodCategory) {
            if selected.contains(category) {
                selected.remove(category)
            } else {
                selected.insert(category)
            }
        }
    }
}
