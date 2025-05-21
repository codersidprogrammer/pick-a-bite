//
//  PrimaryButtonComponentView.swift
//  PickABite
//
//  Created by Dimaseditiya on 05/04/25.
//

import SwiftUI


struct PrimaryButtonComponentView: View {
    var text: String = ""
    var action: () -> Void
    var isDisabled: Bool
    var iconName: String
    
    init(_ text: String, action: @escaping () -> Void, isDisabled: Bool = false, iconName: String = "") {
        self.text = text
        self.action = action
        self.isDisabled = isDisabled
        self.iconName = iconName
    }
    
    var body: some View {
        Button(
            action: {
                action()
            },
            label: {
                Label(text, systemImage: iconName)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: Sizing.xl2)
                    .frame(maxWidth: .infinity)
                    .background(Color.kombuGreen)
                    .cornerRadius(Sizing.sm)
            }
        )
    }
}

struct BasicButtonComponentView: View {
    var text: String = ""
    var action: () -> Void
    var isDisabled: Bool
    var iconName: String
    
    init(_ text: String, action: @escaping () -> Void, isDisabled: Bool = false, iconName: String = "") {
        self.text = text
        self.action = action
        self.isDisabled = isDisabled
        self.iconName = iconName
    }
    
    var body: some View {
        Button(
            action: {
                action()
            },
            label: {
                Label(text, systemImage: iconName)
                    .font(.headline)
                    .foregroundColor(.kombuGreen)
                    .frame(height: Sizing.xl2)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(Sizing.lg2)
            }
        )
    }
}

#Preview {
    PrimaryButtonComponentView(
        "Click Me",
        action: { print("Button Clicked") },
        isDisabled: false
    )
    
    BasicButtonComponentView(
        "Click Me",
        action: { print("Button Clicked") },
        isDisabled: false
    )
}
