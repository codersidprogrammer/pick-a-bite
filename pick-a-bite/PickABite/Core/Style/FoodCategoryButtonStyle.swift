//
//  ButtonStyle.swift
//  PickABite
//
//  Created by Abimanyu Damarjati on 26/03/25.
//

import SwiftUI

struct FoodCategoryButtonStyle: ButtonStyle {
    var isActive: Bool = false
    @Environment(\.isEnabled) var isEnabled
    
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .padding(EdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14))
            .foregroundColor(isActive ? .white : .kombuGreen)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(
                        .shadow(
                            .inner(
                                color: !isEnabled ? Color.cosmicLatte : isActive ? Color(
                                    "ButtonDefaultActiveDarkShadow"
                                 ) : Color("ButtonDefaultLightShadow"
                                          ) ,
                                radius: 2,
                                x: 3,
                                y: 3
                            )
                        )
                        .shadow(
                            .inner(
                                color: !isEnabled ? Color.cosmicLatte : (isActive ? Color(
                                    "ButtonDefaultActiveLightShadow"
                                ) : Color(
                                    "ButtonDefaultDarkShadow"
                                )),
                                radius: 2,
                                x: -3,
                                y: -3
                            )
                        )
                    )
                    .foregroundColor(
                        !isEnabled ? .cosmicLatte : (isActive ? .vividTangelo : Color(
                            "CosmicLatte"
                        ))
                    )
            )
            .animation(.easeInOut(duration: 0.05), value: isActive)
            .cornerRadius(18)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(
                .easeInOut(duration: 0.05),
                value: configuration.isPressed
            )

    }

}

#Preview {
    @Previewable @State var isActive: Bool = false
    
    Button(action: {
        isActive.toggle()
    }) {
        Text("Hello World!")
    }
    .buttonStyle(FoodCategoryButtonStyle(
        isActive: isActive
    )).disabled(true)
}
