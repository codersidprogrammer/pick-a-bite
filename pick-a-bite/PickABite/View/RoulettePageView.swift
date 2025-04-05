//
//  RoulettePageView.swift
//  PickABite
//
//  Created by Dimaseditiya on 03/04/25.
//

import SwiftUI

class RoulettePageService: ObservableObject {
    let service: MainPredictService = MainPredictService()
    
    func predictAsSegmentData() -> [SegmentData] {
        Logger.log("Generating")
        let jsonDict: [String: Any] = [
            //            "Coffee_Tea": 0,
            "Seafood": 1,
            //            "Juice_Beverages": 1,
            //            "Meat_Protein": 1
        ]
        
        let _predicts = service.predict(
            preferences: PreferenceDto.fromJson(jsonDict) ?? PreferenceDto()
        )
        
        return _predicts
            .sorted(by: { $0.key < $1.key })
            .prefix(10)
            .enumerated()
            .map { index, elements in
                let (key, value) = elements
                let isEven = index % 2 == 0
                let segment = SegmentData(
                    index: value,
                    color: isEven ? Color.primary : Color.secondary,
                    description: key
                )
                return segment
            }
    }
}

struct HalfSheetView: View {
    @Binding var selectedSegment: SegmentData
    var rouletteController: RouletteController
    
    var body: some View {
        VStack(alignment: .leading){
            CardMediaComponentView(
                title: selectedSegment.description,
                subtitle: "default subtitle",
                imageName: "default_restaurant",
                location: "default location",
                distance: "0",
                buttonAction: {
                    Logger.log("Came from half sheet")
                },
                buttonIconName: "map.fill"
            )
            .padding(.vertical, Sizing.xl)
            .padding(.horizontal, Sizing.sm)
            
            Spacer()
            Text("Want try more?")
                .font(.headline)
                .padding(.leading, Sizing.md)
            
            
            PrimaryButtonComponentView(
                "Spin more (2x)",
                action: {
                    Logger.log("Came from component view")
                    rouletteController.isSelected.toggle()
                    rouletteController.spin()
                },
                isDisabled: true
            )
        }
    }
}

struct RoulettePageView: View {
    
    @State var presented: Bool = true
    @StateObject var service: RoulettePageService = .init()
    @StateObject var rouletteController: RouletteController = .init(segmentData: [])
    
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
                    .onTapGesture {
                        rouletteController.spin()
                        Logger.log("Tapped")
                    }
                    .navigationTitle("Roulette Page")
                    .navigationBarTitleDisplayMode(.inline)
                    .padding(.all, Sizing.md)
                    .sheet(isPresented: $rouletteController.isSelected) {
                        HalfSheetView(
                            selectedSegment: $rouletteController.selectedSegment,
                            rouletteController: rouletteController
                        )
                            .presentationDetents([.medium, .large])
                            .presentationDragIndicator(.visible)
                    }
                    .onAppear(){
                        rouletteController.setSegment(data: service.predictAsSegmentData())
                    }
                Spacer()
            }
        }
        
    }
}

#Preview {
    RoulettePageView()
}
