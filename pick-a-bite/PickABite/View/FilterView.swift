//
//  FilterView.swift
//  PickABite
//
//  Created by Abimanyu Damarjati on 25/03/25.
//

import SwiftUI

struct FilterView: View {
    var foodCategoriesData: [FoodCategory] = [
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

    @State private var isDragging = false

    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                dragLocation = value.location

                for (name, frame) in buttonFrames {
                    if frame.contains(dragLocation) {
                        if clickedButtons.contains(name) { return }

                        clickedButtons.insert(name)
                        addCategory(name)
                    }
                }
            }.onEnded { _ in
                clickedButtons.removeAll()
                triggerHaptics.toggle()
            }

    }

    var body: some View {
        NavigationStack {
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
                                }
                            }) {
                                Text(item.name)
                            }
                            .buttonStyle(
                                FoodCategoryButtonStyle(
                                    isActive: selectedName.contains(item.name)
                                )
                            )
                            .sensoryFeedback(
                                .impact(weight: .light),
                                trigger: triggerHaptics
                            )
                            .background(
                                TrackFrameView(
                                    name: item.name,
                                    buttonFrames: $buttonFrames
                                )
                            )
                        }
                    }.padding()
                        .contentShape(Rectangle())

                }.padding()
                Spacer()
                NavigationLink {
                    RoulettePageView()
                } label: {
                    Label("Spin the weel", systemImage: "chart.pie.fill")
                        .font(.headline)
                        .foregroundColor(.white)
                        .containerRelativeFrame(.horizontal)
                        .padding(.horizontal, -36)
                        .frame(height: 64)
                }
                .frame(height: 64)
                .buttonStyle(.borderedProminent)
                .cornerRadius(28)
            }
            .gesture(drag)
            .background(Color.gray.opacity(0.2))
        }
    }

}

struct TrackFrameView: View {
    let name: String
    @Binding var buttonFrames: [String: CGRect]

    var body: some View {
        GeometryReader { geo in
            Color.clear
                .onAppear {
                    DispatchQueue.main.async {
                        buttonFrames[name] = CGRect(
                            x: geo.frame(in: .global).minX,
                            y: geo.frame(in: .global).minY - 80,
                            width: geo.frame(in: .global).width,
                            height: geo.frame(in: .global).height)
                    }
                }
        }
    }
}

#Preview {
    FilterView()
}
