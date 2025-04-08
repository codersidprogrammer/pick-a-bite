//
//  FilterView.swift
//  PickABite
//
//  Created by Abimanyu Damarjati on 25/03/25.
//

import SwiftUI

struct FilterView: View {
    
    // NOTE (Dimas): add for navigation purpose
    @Binding var path: NavigationPath
    
    @State private var isClicked = false
    //    let foodCategoriesJson: PreferenceDto = PreferenceDto.fromJson([:]) ??
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
        FoodCategory(
            key: "Indonesian_Cuisine",
            name: "🇮🇩 Indonesian Cuisine"
        ),
        FoodCategory(key: "Fast_Food", name: "🍔 Fast Food"),
        FoodCategory(key: "Refreshing_Fresh", name: "🥝 Refreshing Fresh"),
        FoodCategory(key: "Dining_Experience", name: "🍽️ Dining Experience"),
    ]

    @State var selectedName: Set<String> = []
    @State private var dragLocation: CGPoint = .zero
    @State private var buttonFrames: [String: CGRect] = [:]
    @State private var clickedButtons: Set<String> = []  // Track clicked buttons
    @State private var triggerHaptics = false
    
    func addCategory(_ name: String) {
        if selectedName.contains(name) {
            selectedName.remove(name)
        } else {
            selectedName.insert(name)
        }
    }
    
    var onSelectionChange: (Set<String>) -> Void
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("What are you craving for today?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                Spacer()
                WrappedLayout {
                    ForEach(foodCategoriesData, id: \.name) { item in
                        Button(action: {
                            withAnimation {
                                addCategory(item.name)
                                triggerHaptics.toggle()
                                onSelectionChange(selectedName)
                            }
                        }) {
                            Text(item.name)
                        }
                        .buttonStyle(
                            FoodCategoryButtonStyle(
                                isActive: selectedName.contains(item.name)
                            )
                        )
                        .disabled(
                            selectedName.count == 5 && !selectedName
                                .contains(item.name)
                        )
                        .sensoryFeedback(
                            .impact(weight: .light),
                            trigger: triggerHaptics
                        )
                    }
                }
                .padding()
                .contentShape(Rectangle())
            }
            .padding()
        }
    }
    
}

extension Character {
    var isEmoji: Bool {
        return unicodeScalars
            .contains {
                $0.properties.isEmoji && (
                    $0.value > 0x238C || $0.properties.isEmojiPresentation
                )
            }
    }
}


#Preview {
    @Previewable @State var path: NavigationPath = NavigationPath()
    FilterView(path: $path, onSelectionChange: {
        preferences in
        for p in preferences {
//            Logger.log(p)
        }
    })
}
