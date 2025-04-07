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
    
    init(_ text: String, action: @escaping () -> Void, isDisabled: Bool = false) {
        self.text = text
        self.action = action
        self.isDisabled = isDisabled
    }
    
    var body: some View {
        Button(
            action: {
                action()
            },
            label: {
                Text(text)
                    .primaryTextButton(isDisabled: isDisabled)
            }
        )
        .disabled(isDisabled)
    }
}

#Preview {
    PrimaryButtonComponentView(
        "Click Me",
        action: { print("Button Clicked") },
        isDisabled: false
    )
}
