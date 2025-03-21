//
//  pick_a_bite_playgroundApp.swift
//  pick-a-bite-playground
//
//  Created by Abimanyu Damarjati on 19/03/25.
//

import SwiftUI
import SwiftData

@main
struct pick_a_bite_playgroundApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
