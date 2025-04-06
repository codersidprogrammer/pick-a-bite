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
            Text("Maybe you'll like")
                .font(.headline)
                .padding(.leading, Sizing.md)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Sizing.xs) {
                    let segmentData = Array(rouletteController.segmentData.enumerated())
                    
                    
                    if segmentData.count > 1 {
                        let takeTwo = segmentData.shuffled().prefix(2)
                        ForEach(takeTwo, id: \.offset) { index, segment in
                            SimpleCardComponentView(
                                title: segment.description,
                                subtitle: "Nice to try"
                            )
                            .onTapGesture {
                                // TODO: change to actual action
                                Logger.log("You choose \(segment.description)")
                            }
                        }
                    }
                }
                .padding(.horizontal, Sizing.md)
            }
            .padding(.bottom, Sizing.xl)
            
            Text("Want try more?")
                .font(.headline)
                .padding(.leading, Sizing.md)
            
            PrimaryButtonComponentView(
                "Spin more (\(rouletteController.countChances)x)",
                action: {
                    rouletteController.isSelected.toggle()
                    rouletteController.spin()
                },
                isDisabled: !rouletteController.havingChance
            )
        }
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
