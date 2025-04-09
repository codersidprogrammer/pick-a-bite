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
        VStack(alignment: .center){
            CardMediaComponentView(
                title: selectedSegment.description,
                subtitle: "",
                imageName: "default_restaurant",
                location: "Hope this is best for you",
                distance: "",
                buttonAction: {
                    if let url = URL(string: "http://maps.apple.com/?q=\(selectedSegment.description)") {
                        UIApplication.shared.open(url)
                    }
                },
                buttonIconName: "safari.fill"
            )
            .padding(.vertical, Sizing.lg3)
            .padding(.horizontal, Sizing.sm)
            
            Spacer()
            VStack(alignment: .leading) {
                Text("Maybe you'll like")
                    .font(.headline)
                    .padding(.leading, Sizing.md)
                HStack(spacing: Sizing.xs) {
                    let segmentData = Array(rouletteController.segmentData.enumerated())
                    if segmentData.count > 1 {
                        let takeTwo = segmentData.shuffled().prefix(2)
                        ForEach(takeTwo, id: \.offset) { index, segment in
                            SimpleCardComponentView(
                                title: segment.description,
                                subtitle: "Nice to try"
                            )
                            .padding(.trailing, Sizing.sm)
                            .onTapGesture {
                                if let url = URL(string: "http://maps.apple.com/?q=\(selectedSegment.description)") {
                                    UIApplication.shared.open(url)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, Sizing.md)
                .padding(.bottom, Sizing.lg3)
                //                ScrollView(.horizontal, showsIndicators: false) {
                //
                //                }
                //                .padding(.bottom, Sizing.lg3)
            }
            
            
            VStack(alignment: .leading){
                Text("Want try more?")
                    .font(.headline)
                
                PrimaryButtonComponentView(
                    "Spin more (\(rouletteController.countChances)x)",
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
