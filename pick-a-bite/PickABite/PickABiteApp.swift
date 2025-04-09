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
    @StateObject var launchScreenState = LaunchScreenStateManager()
    
    var body: some Scene {
        WindowGroup {
//            HapticLoopView()
            ZStack {
                MainView()
                
                if launchScreenState.state != .finished {
                    LaunchScreenView()
                }
            }.environmentObject(launchScreenState)
        }
        .environment(
            \.modelContext,
             RepositoryInitializer.instance.modelContainer.mainContext
        )
    }
}
