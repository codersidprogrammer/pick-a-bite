//
//  MainView.swift
//  PickABite
//
//  Created by Dimaseditiya on 07/04/25.
//

import SwiftData
import SwiftUI

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var rouletteService:
    RoulettePageService<UserHistoryRepository> = {
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
    @State private var isLinkActive = false
    @State var selectedPreferences: [String] = []
    
    private let now = Date.now
    
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                FilterView(path: $path) {
                    _preferences in
                    selectedPreferences = Array(_preferences)
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
                            
                        } label: {
                            Image(
                                systemName:
                                    "clock.arrow.trianglehead.counterclockwise.rotate.90"
                            )
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
                        isClicked.toggle()
                        isLinkActive = true
                    }) {
                        Label("Find your lucky!", systemImage: "hands.sparkles.fill")
                            .font(.headline)
                            .foregroundColor(.white)
                            .containerRelativeFrame(.horizontal)
                            .padding(.horizontal, -36)
                            .frame(height: 64)
                    }
                    .disabled(selectedPreferences.isEmpty)
                    .foregroundStyle(Color("CosmicLatte"))
                    .sensoryFeedback(
                        .impact(weight: .light),
                        trigger: isClicked
                    )
                    .frame(height: Sizing.xl2)
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(Sizing.lg2)
                }
                .navigationDestination(isPresented: $isLinkActive) {
                    RoulettePageView(
                        preferences: selectedPreferences
                    )
                    .navigationTitle("Roulette Page")
                    .environmentObject(rouletteService)
                }
            }.background(
                LinearGradient(colors: [.cosmicLatte, .papayaWhip], startPoint: .top, endPoint: .bottom)
            )
        }
        .onAppear {
            if !isInitialized {
                rouletteService.userHistoryRepo = UserHistoryRepository(
                    context: modelContext
                )
                isInitialized = true
            }
        }
        
    }
}

#Preview {
    MainView()
}
