//
//  RoulettePageView.swift
//  PickABite
//
//  Created by Dimaseditiya on 03/04/25.
//

import SwiftUI
import SwiftData


struct RoulettePageView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var service:
    RoulettePageService<UserHistoryRepository> = {
        // NOTE: Dummy init with a temporary context (won't be used)
        let dummyContext = try! ModelContainer(
            for: UserHistoryModel.self
        ).mainContext
        let dummyRepo = UserHistoryRepository(context: dummyContext)
        return RoulettePageService(repository: dummyRepo)
    }()
    @StateObject var rouletteController: RouletteController = .init(segmentData: [])
    @State var whenSpinInfoTap: Bool = false
    
    var whenNotHavingChance: Binding<Bool> {
        Binding(
            get: { !rouletteController.havingChance },
            set: { rouletteController.havingChance = !$0 }
        )
    }
    
    let preferences: [String]
    
    init() {
        self.preferences = [
            "Spicy",
            "Coffee",
            "Cozy"
        ]
    }
    init(preferences: [String]) {
        self.preferences = preferences
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                Text("Your Preferences")
                    .font(.headline)
                    .padding(.horizontal, Sizing.md)
                    .padding(.top, Sizing.xl)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Sizing.xs) {
                        ForEach(preferences, id: \.self) { value in
                            ChipOutlinedComponentView(value)
                        }
                    }
                    .padding(.horizontal, Sizing.md)
                }
                
                RouletteComponentView(controller: rouletteController)
                    .navigationTitle("Roulette Page")
                    .navigationBarTitleDisplayMode(.inline)
                    .padding(.all, Sizing.md)
                    .sheet(isPresented: $rouletteController.isSelected) {
                        HalfSheetView(
                            selectedSegment: $rouletteController.selectedSegment,
                            rouletteController: .constant(rouletteController)
                        )
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                        .onAppear(){
                            do {
                                try service.userHistoryRepo.add(
                                    UserHistoryModel(
                                        tenantName: rouletteController.selectedSegment.description,
                                        
                                        // TODO: Change this into real selected preferences
                                        criteria: preferences.map{
                                            value in
                                            return value
                                        },
                                        spinSequence: rouletteController.countChances
                                    )
                                )
                            } catch let error {
                                Logger.error(error.localizedDescription)
                            }
                        }
                    }
                    .alert("Oops!", isPresented: whenNotHavingChance) {
                        
                    } message: {
                        Text("Unfortunatelly! you have no any chances now")
                    }
                    .onAppear(){
                        rouletteController.setSegment(
                            data: service.predictAsSegmentData(preffs: preferences)
                        )
                    }
                    .onTapGesture {
                        rouletteController.spin()
                    }
                Spacer()
                SimpleCardComponentView(
                    title: "Spin count \(rouletteController.countChances)x",
                    subtitle: "Tap me for detail",
                    iconName: "info.circle.fill",
                    iconColor: .primary
                )
                .padding(.all, Sizing.md)
                .onTapGesture {
                    whenSpinInfoTap.toggle()
                }
                .alert("Info", isPresented: $whenSpinInfoTap) {
                    
                } message: {
                    Text("Every day you only have 3 chances to spin, so make sure to use them wisely! Good luck!")
                }
            }
        }
        
    }
}

#Preview {
    @Previewable @State var isInitialized: Bool = false
    var service: RoulettePageService<UserHistoryRepository> = {
        // NOTE: Dummy init with a temporary context (won't be used)
        let dummyContext = try! ModelContainer(for: UserHistoryModel.self).mainContext
        let dummyRepo = UserHistoryRepository(context: dummyContext)
        return RoulettePageService(repository: dummyRepo)
    }()
    
    
    RoulettePageView()
        .environmentObject(service)
        .environment(\.modelContext, RepositoryInitializer.instance.modelContainer.mainContext)
        .onAppear {
            if !isInitialized {
                service.userHistoryRepo = UserHistoryRepository(context: RepositoryInitializer.instance.modelContainer.mainContext)
                isInitialized = true
            }
        }
    
    Button("Show Log") {
        let test = try! service.userHistoryRepo.fetchAll()
        for t in test {
            Logger.log(t.toJsonString() ?? "{}")
        }
    }
}
