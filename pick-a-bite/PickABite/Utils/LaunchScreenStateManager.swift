//
//  LaunchScreenStateManager.swift
//  PickABite
//
//  Created by Abimanyu Damarjati on 09/04/25.
//


import Foundation

final class LaunchScreenStateManager: ObservableObject {
    @MainActor @Published private(set) var state: LaunchScreenStep = .firstStep
    @MainActor func dismiss() {
        Task {
            try? await Task.sleep(for: Duration.seconds(1))
            self.state = .finished 
        } 
    } 
}
