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

    func normalizedKey(from name: String) -> String {
        let components =
            name
            .components(separatedBy: .whitespaces)
            .filter { !$0.contains(where: { $0.isEmoji }) }
        return components.joined(separator: "_")
    }

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
                    .disabled(selectedPreferences.isEmpty)
                    .foregroundStyle(Color("CosmicLatte"))
                    .sensoryFeedback(
                        .impact(weight: .light),
                        trigger: isClicked
                    )
                    .frame(height: 64)
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(28)

                }
                // ✅ New way to trigger navigation
                .navigationDestination(isPresented: $isLinkActive) {
                    RoulettePageView(
                        preferences: selectedPreferences.map {
                            value in
                            return normalizedKey(from: value)
                        }
                    )
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
