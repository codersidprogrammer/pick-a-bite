//
//  SimpleCardComponentView.swift
//  PickABite
//
//  Created by Dimaseditiya on 06/04/25.
//

import SwiftUI

struct SimpleCardComponentView: View {
    var title: String
    var subtitle: String
    var iconName: String
    var iconColor: Color
    
    init(title: String, subtitle: String, iconName: String = "info.circle.fill", iconColor: Color = Color.vividTangelo) {
        self.title = title
        self.subtitle = subtitle
        self.iconName = iconName
        self.iconColor = iconColor
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: iconName)
                .font(.title)
                .foregroundColor(iconColor)
            
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundStyle(Color.kombuGreen)
                    .font(.headline)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
        .padding()
        .background(Color.papayaWhip) // You can use .ultraThinMaterial for glass effect
        .overlay(
            RoundedRectangle(cornerRadius: Sizing.xs)
                .stroke(Color.papayaWhip.opacity(0.3), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: Sizing.xs))
        .shadow(radius: 0)
    }
}

#Preview {
    SimpleCardComponentView(title: "Starbucks", subtitle: "Taste american coffee")
}
