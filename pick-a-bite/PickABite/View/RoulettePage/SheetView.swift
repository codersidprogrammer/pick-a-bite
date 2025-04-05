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
            Text("Want try more?")
                .font(.headline)
                .padding(.leading, Sizing.md)
            
            
            PrimaryButtonComponentView(
                "Spin more (\(rouletteController.countChange)x)",
                action: {
                    Logger.log("Came from component view")
                    rouletteController.isSelected.toggle()
                    rouletteController.spin()
                },
                isDisabled: !rouletteController.havingChance
            )
        }
    }
}
