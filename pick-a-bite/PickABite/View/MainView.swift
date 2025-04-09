//
//  MainView.swift
//  PickABite
//
//  Created by Dimaseditiya on 07/04/25.
//

import SwiftData
import SwiftUI
import Foundation

struct MainView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    
    @Environment(\.modelContext) private var modelContext
    @StateObject private var rouletteService: RoulettePageService<UserHistoryRepository> = {
        // NOTE: Dummy init with a temporary context (won't be used)
        let dummyContext = try! ModelContainer(
            for: UserHistoryModel.self
        ).mainContext
        let dummyRepo = UserHistoryRepository(context: dummyContext)
        return RoulettePageService(repository: dummyRepo)
    }()
    
    @State var isInitialized: Bool = false
    @State var path = NavigationPath()
    @State private var isClicked = false
    
    @State private var isGotoRouletteView = false
    @State private var isGotoHistoryView = false
    
    @State var selectedPreferences: [String] = []
    
    private let now = Date.now
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                FilterView(path: $path) {
                    preferences in
                    selectedPreferences = preferences.map({ $0.name })
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        VStack(alignment: .leading) {
                            Text(
                                now,
                                format: .dateTime.day().month(.wide).year()
                            )
                            .font(.caption)
                            .textCase(.uppercase)
                            .foregroundStyle(.kombuGreen.opacity(0.5))
                            Text(now, format: .dateTime.weekday(.wide))
                                .font(.headline)
                                .fontWeight(.bold)
                                .textCase(.uppercase)
                                .foregroundStyle(.kombuGreen)
                        }
                        .padding([.leading], Sizing.md)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isGotoHistoryView.toggle()
                        } label: {
                            Image(
                                systemName:
                                    "clock.arrow.trianglehead.counterclockwise.rotate.90"
                            )
                        }
                        .navigationDestination(
                            isPresented: $isGotoHistoryView
                        ) {
                            HistoryPageView()
                                .navigationTitle("History Page")
                                .environmentObject(rouletteService)
                        }
                        .padding([.trailing], Sizing.md)
                        .foregroundStyle(Color("KombuGreen"))
                    }
                }
                
                VStack {
                    Button(action: {
                        guard !selectedPreferences.isEmpty else {
                            return
                        }
                        isGotoRouletteView = true
                    }) {
                        Label(
                            "Find your lucky!",
                            systemImage: "hands.sparkles.fill"
                        )
                        .font(.headline)
                        .foregroundColor(.white)
                        .containerRelativeFrame(.horizontal)
                        .padding(.horizontal, -36)
                        .frame(height: 64)
                    }
                    .disabled(selectedPreferences.isEmpty)
                    .foregroundStyle(Color("CosmicLatte"))
                    .frame(height: Sizing.xl2)
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(Sizing.lg2)
                    .navigationDestination(isPresented: $isGotoRouletteView) {
                        RoulettePageView(
                            preferences: selectedPreferences
                        )
                        .navigationTitle("Roulette Page")
                        .environmentObject(rouletteService)
                    }
                }.navigationDestination(isPresented: $isGotoRouletteView) {
                    RoulettePageView(
                        preferences: selectedPreferences
                    )
                    .navigationTitle("Roulette Page")
                    .environmentObject(rouletteService)
                }
            }
            .background(
                LinearGradient(
                    colors: [.cosmicLatte, .papayaWhip],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .task {
            try? await Task.sleep(for: Duration.seconds(1))
            self.launchScreenState.dismiss()
        }
        .onAppear {
            if !isInitialized {
                rouletteService.userHistoryRepo = UserHistoryRepository(
                    context: modelContext
                )
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(LaunchScreenStateManager())
}
