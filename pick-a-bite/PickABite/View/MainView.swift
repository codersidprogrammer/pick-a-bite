//
//  MainView.swift
//  PickABite
//
//  Created by Dimaseditiya on 07/04/25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var rouletteService: RoulettePageService<UserHistoryRepository> = {
        // NOTE: Dummy init with a temporary context (won't be used)
        let dummyContext = try! ModelContainer(for: UserHistoryModel.self).mainContext
        let dummyRepo = UserHistoryRepository(context: dummyContext)
        return RoulettePageService(repository: dummyRepo)
    }()
    
    @State var isInitialized: Bool = false
    
    var body: some View {
        RoulettePageView()
            .environmentObject(rouletteService)
            .onAppear {
                if !isInitialized {
                    rouletteService.userHistoryRepo = UserHistoryRepository(context: modelContext)
                    isInitialized = true
                }
            }
        
        Button("Show Log") {
            let test = try! rouletteService.userHistoryRepo.fetchAll()
            for t in test {
                Logger.log(t.toJsonString() ?? "{}")
            }
        }
    }
}

#Preview {
    MainView()
}
