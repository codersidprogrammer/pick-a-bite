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
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "chevron.forward.circle.fill")
                .font(.title)
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial) // You can use .ultraThinMaterial for glass effect
        .overlay(
            RoundedRectangle(cornerRadius: Sizing.xs)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: Sizing.xs))
        .shadow(radius: 0)
    }
}

#Preview {
    SimpleCardComponentView(title: "Starbucks", subtitle: "Taste american coffee")
}
