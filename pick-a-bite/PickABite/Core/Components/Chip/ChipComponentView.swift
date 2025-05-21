//
//  ChipComponentView.swift
//  PickABite
//
//  Created by Dimaseditiya on 04/04/25.
//

import SwiftUI

struct ChipComponentView: View {
    var icon: String
    var text: String
    
    var body: some View {
        HStack{
//            Image(systemName: icon)
//                .resizable()
//                .frame(width: 20, height: 20)
//                .foregroundColor(.white)
            
            Text(text)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.trailing, Sizing.xs)
                .foregroundStyle(.white)
        }
        .padding(.all, Sizing.sm)
        .background(Color.primary)
        .clipShape(Capsule())
    }
}

#Preview {
    ChipComponentView(icon: "person.crop.circle", text: "🌶️ dimass")
}
