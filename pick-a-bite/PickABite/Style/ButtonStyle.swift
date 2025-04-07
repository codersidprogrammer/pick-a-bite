//
//  ButtonStyle.swift
//  PickABite
//
//  Created by Abimanyu Damarjati on 26/03/25.
//

import SwiftUI

struct FoodCategoryButtonStyle: ButtonStyle {
    var isActive: Bool = false
    
    
    func makeBody(configuration: Self.Configuration) -> some View {
        //        print(isActive)
        return configuration.label
            .padding(10)
            .foregroundColor(isActive ? .white : .black)
            .background(isActive ? .blue : .white)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(
                        .shadow(
                            .inner(
                                color: isActive ? Color(
                                    red: 0/255,
                                    green: 64/255,
                                    blue: 221/255
                                ) : Color("ButtonDefaultLightShadow"
                                ),
                                radius: 2,
                                x: 3,
                                y: 3
                            )
                        )
                        .shadow(
                            .inner(
                                color: isActive ? Color(
                                    red: 64/255,
                                    green: 156/255,
                                    blue: 221/255
                                ) : Color(
                                    "ButtonDefaultDarkShadow"
                                ),
                                radius: 2,
                                x: -3,
                                y: -3
                            )
                        )
                    )
                    .foregroundColor(
                        isActive ? .blue : Color("ButtonForeground")
                    )
            )
            .animation(.easeInOut(duration: 0.05), value: isActive)
            .cornerRadius(18)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .scaleEffect(isActive ? 1.05 : 1)
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
    .buttonStyle(FoodCategoryButtonStyle(isActive: isActive))
}
