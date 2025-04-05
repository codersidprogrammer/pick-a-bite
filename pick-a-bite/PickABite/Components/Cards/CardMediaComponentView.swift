//
//  CardMediaComponentView.swift
//  PickABite
//
//  Created by Dimaseditiya on 05/04/25.
//

import SwiftUI

struct CardMediaComponentView: View {
     var title: String
     var subtitle: String
     var imageName: String
     var location: String
     var distance: String
     var buttonAction: () -> Void
     var buttonIconName: String
    
    
    
    var body: some View {
        HStack(alignment: .center, spacing: Sizing.xl) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: Sizing.xl3 , height: Sizing.xl3)
                .clipShape(RoundedRectangle(cornerRadius: Sizing.sm))
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                Text(subtitle)
                    .font(.caption)
                    .padding(.bottom, Sizing.md)
                
                HStack {
                    Text(location)
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Text("•")
                    Text("\(distance)m")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .padding(.trailing, Sizing.xs)
                }
            }
            Button(action: {
                buttonAction()
            }) {
                Image(systemName: buttonIconName)
                    .font(.title)
                    .foregroundColor(.primary)
            }
        }
    }
}

#Preview {
    CardMediaComponentView(
        title: "dimas",
        subtitle:" powerfull",
        imageName: "default_restaurant",
        location: "The breeze",
        distance: "200",
        buttonAction: {
            print("clicked")
        },
        buttonIconName: "map.fill"
        )
}
