//
//  RoulettePageView.swift
//  PickABite
//
//  Created by Dimaseditiya on 03/04/25.
//

import SwiftUI


struct RoulettePageView: View {
    
    @EnvironmentObject var service: RoulettePageService<MockUserHistoryRepository> // TODO: Change this to real repo
    @StateObject var rouletteController: RouletteController = .init(segmentData: [])
    
    var whenNotHavingChance: Binding<Bool> {
        Binding(
            get: { !rouletteController.havingChance },
            set: { rouletteController.havingChance = !$0 }
        )
    }
    
    let dummyChip: [String:String] = [
        "flame.fill": "Spicy",
        "cup.and.heat.waves.fill": "Coffee",
        "person.crop.circle.fill": "Cozy"
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                Text("Your Preferences")
                    .font(.headline)
                    .padding(.horizontal, Sizing.md)
                    .padding(.top, Sizing.xl)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Sizing.xs) {
                        ForEach(Array(dummyChip), id: \.key) { icon, value in
                            ChipComponentView(icon: icon, text: value)
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
                                        criteria: dummyChip.map{
                                            key, value in
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
                        rouletteController.setSegment(data: service.predictAsSegmentData())
                    }
                    .onTapGesture {
                        rouletteController.spin()
                    }
                Spacer()
            }
        }
        
    }
}

#Preview {
    let mockRepo = MockUserHistoryRepository()
    let service = RoulettePageService(repository: mockRepo)
    
    RoulettePageView()
        .environmentObject(service)
        .environment(\.modelContext, RepositoryInitializer.instance.modelContainer.mainContext)
}
