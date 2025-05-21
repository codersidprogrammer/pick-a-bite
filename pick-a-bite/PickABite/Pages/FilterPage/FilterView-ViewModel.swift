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
        let foodCategoriesData: [FoodCategoryModel] = [
            FoodCategoryModel(key: "Coffee_Tea", name: "☕ Coffe Tea"),
            FoodCategoryModel(key: "Sweet_Desserts", name: "🍰 Sweet Desserts"),
            FoodCategoryModel(key: "Juice_Beverages", name: "🥤 Juice Beverages"),
            FoodCategoryModel(key: "Healthy_Vegan", name: "🥗 Healthy Vegan"),
            FoodCategoryModel(key: "Meat_Protein", name: "🥩 Meat Protein"),
            FoodCategoryModel(key: "Seafood", name: "🦐 Seafood"),
            FoodCategoryModel(key: "Spicy_Flavors", name: "🌶️ Spicy Flavorts"),
            FoodCategoryModel(key: "Comfort_Food", name: "🍪 Comfort Food"),
            FoodCategoryModel(key: "Noodles_Rice", name: "🍜 Noodles Rice"),
            FoodCategoryModel(key: "Bakery_Bread", name: "🥖 Bakery Bread"),
            FoodCategoryModel(key: "Hangout_Ambience", name: "🎨 Hangout Ambience"),
            FoodCategoryModel(key: "Alcohol_Bar", name: "🍷 Alcohol Bar"),
            FoodCategoryModel(key: "Snacks_Appetizers", name: "🍟 Snacks Appetizers"),
            FoodCategoryModel(key: "Lunch_Meal", name: "🍱 Lunch Meal"),
            FoodCategoryModel(key: "Soups_Broths", name: "🍲 Soups Broths"),
            FoodCategoryModel(key: "Japanese_Cuisine", name: "🇯🇵 Japanese Cuisine"),
            FoodCategoryModel(key: "Indonesian_Cuisine", name: "🇮🇩 Indonesian Cuisine"),
            FoodCategoryModel(key: "Fast_Food", name: "🍔 Fast Food"),
            FoodCategoryModel(key: "Refreshing_Fresh", name: "🥝 Refreshing Fresh"),
            FoodCategoryModel(key: "Dining_Experience", name: "🍽️ Dining Experience"),
        ]
        
        private(set) var selected: Set<FoodCategoryModel> = []
        
        func addOrRemoveSelected(_ category: FoodCategoryModel) {
            if selected.contains(category) {
                selected.remove(category)
            } else {
                selected.insert(category)
            }
        }
    }
}
