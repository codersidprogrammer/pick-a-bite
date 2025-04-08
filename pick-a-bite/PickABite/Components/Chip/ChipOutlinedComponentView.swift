//
//  ChipOutlinedComponentView.swift
//  PickABite
//
//  Created by Dimaseditiya on 07/04/25.
//

import SwiftUI

struct ChipOutlinedComponentView: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundStyle(Color.primary)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.trailing, Sizing.xs)
                
        }
        .padding(.all, Sizing.sm)
        .overlay(
            Capsule()
                .stroke(Color.primary, lineWidth: 1)
        )
        .background(
            Capsule()
                .fill(Color.clear)
        )
    }
}

#Preview {
    ChipOutlinedComponentView("☕️ Coffee")
}
