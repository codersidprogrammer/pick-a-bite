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
    @State var path = NavigationPath()
    @State private var isClicked = false
    @State private var isLinkActive = false
    @State var selectedPreferences: [String] = []
    
    private let now = Date.now
    
    var body: some View {
        NavigationStack(path: $path) {
            FilterView(path: $path) {
                _preferences in
                selectedPreferences = Array(_preferences)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        VStack (alignment: .leading) {
                            Text(
                                now,
                                format: .dateTime.day().month(.wide).year()
                            )
                            .font(.caption)
                            .textCase(.uppercase)
                            .foregroundStyle(.secondary)
                            Text(now, format: .dateTime.weekday(.wide))
                                .font(.headline).textCase(.uppercase)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(
                                systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90"
                            )
                        }
                    }
                    .padding()
                }
            }
            
            Spacer()
            VStack {
                Button(action: {
                    // ✅ Guard condition before navigation
                    guard !selectedPreferences.isEmpty else {
                        // You could show an alert here
                        return
                    }
                    isClicked.toggle()
                    isLinkActive = true
                }) {
                    Label("Spin the wheel", systemImage: "chart.pie.fill")
                        .font(.headline)
                        .foregroundColor(.white)
                        .containerRelativeFrame(.horizontal)
                        .padding(.horizontal, -36)
                        .frame(height: 64)
                }
                .background(Color.gray.opacity(0.2))
                .sensoryFeedback(.impact(weight: .light), trigger: isClicked)
                .frame(height: 64)
                .buttonStyle(.borderedProminent)
                .cornerRadius(28)
                .disabled(selectedPreferences.isEmpty)
                
            }
            // ✅ New way to trigger navigation
            .navigationDestination(isPresented: $isLinkActive) {
                RoulettePageView(preferences: selectedPreferences)
                    .environmentObject(rouletteService)
            }
            
        }
        .onAppear {
            if !isInitialized {
                rouletteService.userHistoryRepo = UserHistoryRepository(context: modelContext)
                isInitialized = true
            }
        }
        
        
        //
        //        Button("Show Log") {
        //            let test = try! rouletteService.userHistoryRepo.fetchAll()
        //            for t in test {
        //                Logger.log(t.toJsonString() ?? "{}")
        //            }
        //        }
    }
}

#Preview {
    MainView()
}
