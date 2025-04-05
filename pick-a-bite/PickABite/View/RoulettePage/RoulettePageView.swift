//
//  RoulettePageView.swift
//  PickABite
//
//  Created by Dimaseditiya on 03/04/25.
//

import SwiftUI


struct RoulettePageView: View {
    
    @State var presented: Bool = true
    @StateObject var service: RoulettePageService = .init()
    @StateObject var rouletteController: RouletteController = .init(segmentData: [])
    
    var notHavingChange: Binding<Bool> {
        Binding(
            get: { !rouletteController.havingChange },
            set: { rouletteController.havingChange = !$0 }
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
                    }
                    .alert("Unlucky!", isPresented: notHavingChange) {
                        
                    } message: {
                        Text("Unfortunatelly! you have no any changes now")
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
    RoulettePageView()
}
