//
//  ContentView.swift
//  pick-a-bite-playground
//
//  Created by Abimanyu Damarjati on 19/03/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            PickerView().tabItem {
                Label("Picker", systemImage: "list.bullet")
            }
            RouletteView().tabItem{
                Label("Roulette", systemImage: "arrow.triangle.2.circlepath")
            }
        } .background(.thinMaterial)
    }
}

#Preview {
    ContentView()
}
