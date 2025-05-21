//
//  SheetView.swift
//  PickABite
//
//  Created by Dimaseditiya on 05/04/25.
//

import SwiftUI

struct HalfSheetView: View {
    @Binding var selectedSegment: SegmentData
    @Binding var rouletteController: RouletteController
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            CardMediaNetworkComponentView(
                imageUrl: Restaurant.filterRestaurants(byName: selectedSegment.description).first?.thumbnail ?? "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/BURGREENS.jpg",
                title: Restaurant.filterRestaurants(byName: selectedSegment.description).first?.name ?? "Default Title",
                subtitle: Restaurant.filterRestaurants(byName: selectedSegment.description).first?.description ?? "Default description"
            )
            .padding(.vertical, Sizing.lg3)
            .padding(.horizontal, Sizing.sm)
            
            Spacer()
            //            VStack(alignment: .leading) {
            //                Text("Maybe you'll like")
            //                    .font(.headline)
            //                    .padding(.leading, Sizing.md)
            //                HStack(spacing: Sizing.xs) {
            //                    let segmentData = Array(rouletteController.segmentData.enumerated())
            //                    if segmentData.count > 1 {
            //                        let takeTwo = segmentData.shuffled().prefix(2)
            //                        ForEach(takeTwo, id: \.offset) { index, segment in
            //                            SimpleCardComponentView(
            //                                title: segment.description,
            //                                subtitle: "Nice to try"
            //                            )
            //                            .padding(.trailing, Sizing.sm)
            //                            .onTapGesture {
            //                                if let url = URL(string: "http://maps.apple.com/?q=\(selectedSegment.description)") {
            //                                    UIApplication.shared.open(url)
            //                                }
            //                            }
            //                        }
            //                    }
            //                }
            //                .padding(.horizontal, Sizing.md)
            //                .padding(.bottom, Sizing.lg3)
            //                ScrollView(.horizontal, showsIndicators: false) {
            //
            //                }
            //                .padding(.bottom, Sizing.lg3)
            //            }
            
            
            VStack(alignment: .center){
                PrimaryButtonComponentView(
                    "Give me direction",
                    action: {
                        if let url = URL(string: "http://maps.apple.com/?q=\(selectedSegment.description)") {
                            UIApplication.shared.open(url)
                        }
                        
                    },
                    isDisabled: !rouletteController.havingChance
                )
                
                BasicButtonComponentView(
                    "Spin left (\(3 - rouletteController.countChances)x)",
                    action: {
                        rouletteController.isSelected.toggle()
                        rouletteController.spin()
                    },
                    isDisabled: !rouletteController.havingChance
                )
            }
            .padding(.horizontal, Sizing.md)
            
            
        }
        .background(Color.cosmicLatte)
    }
}

#Preview {
    @Previewable @State var segmentData: [SegmentData] = [
        SegmentData(index: 0.2, color: Color.primary, description: "Starbucks"),
        SegmentData(index: 0.1, color: Color.primary, description: "Kopi Kenangan"),
        SegmentData(index: 0.05, color: Color.primary, description: "Janji Jiwa"),
        SegmentData(index: 0.3, color: Color.primary, description: "Tomoro Coffee"),
    ]
    
    HalfSheetView(
        selectedSegment: .constant(segmentData[0]),
        rouletteController: .constant(RouletteController(segmentData: segmentData))
    )
}


//?? "Established in 2018, Fore Coffee is a passionate coffee startups aiming to brew the best specialty coffee for our customer. As our name derived from the word forest, we aim to grow fast, strong, tall and bring life to our surrounding. We want our existence to increase coffee quality for our community. Leveraging network and experience, we are using the latest tech for our tools and bean blend. Directly from the selected farmer, high-quality beans are processed and roasted to perfection by ourselves then passed on to our skilled barista, excitedly prepare the cup of happiness to be served to you especially."
