//
//  PickABiteApp.swift
//  PickABite
//
//  Created by Abimanyu Damarjati on 25/03/25.
//

import SwiftUI
import SwiftData

@main
struct PickABiteApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .environment(\.modelContext, RepositoryInitializer.instance.modelContainer.mainContext)
    }
}
