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
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .center, spacing: Sizing.xl) {
                Image("default_restaurant")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Sizing.xl3 , height: Sizing.xl3)
                    .clipShape(RoundedRectangle(cornerRadius: Sizing.sm))
                
                VStack(alignment: .leading) {
                    Text("STARBUCKS")
                        .font(.title)
                    Text("Best Coffee in town")
                        .font(.caption)
                        .padding(.bottom, Sizing.md)
                    
                    HStack {
                        Text("The Breeze")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        Text("•")
                        Text("200m")
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .padding(.trailing, Sizing.xs)
                    }
                }
                Button(action: {
                    print("Icon button tapped")
                }) {
                    Image(systemName: "map.fill")
                        .font(.title)
                        .foregroundColor(.primary)
                }
            }
            .padding(.vertical, Sizing.xl)
            .padding(.horizontal, Sizing.sm)
            
            Spacer()
            Text("Want try more?")
                .font(.headline)
                .padding(.leading, Sizing.md)
            
            Button(
                action: {
                    print("Pressed")
                },
                label: {
                    Text("Spin more (2x)")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: Sizing.xxl)
                        .frame(maxWidth: .infinity)
                        .background(Color.primary)
                        .cornerRadius(Sizing.sm)
                        .padding(.horizontal)
                }
            )
        }
    }
}

struct RoulettePageView: View {
    
    @State var presented: Bool = true
    @StateObject var service: RoulettePageService = .init()
    @StateObject var rouletteController: RouletteController = .init(segmentData: [])
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                Text("Your Preferences")
                    .font(.headline)
                    .padding(.horizontal, Sizing.md)
                    .padding(.top, Sizing.xl)
                
                HStack(spacing: Sizing.xs) {
                    ChipComponentView(icon: "flame.fill", text: "Spicy")
                    ChipComponentView(icon: "cup.and.heat.waves.fill", text: "Coffee")
                    ChipComponentView(icon: "person.crop.circle.fill", text: "Cozy")
                }
                .padding(.horizontal, Sizing.md)
                
                RouletteComponentView(controller: rouletteController)
                    .onTapGesture {
                        rouletteController.spin()
                        Logger.log("Tapped")
                    }
                    .navigationTitle("Roulette Page")
                    .navigationBarTitleDisplayMode(.inline)
                    .padding(.all, Sizing.md)
                    .sheet(isPresented: .constant(true)  /* $rouletteController.isSelected */) {
                        HalfSheetView(selectedSegment: $rouletteController.selectedSegment)
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
