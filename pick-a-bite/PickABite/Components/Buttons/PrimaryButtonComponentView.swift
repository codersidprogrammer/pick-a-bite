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
    
    init(_ text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button(
            action: {
                action()
            },
            label: {
                Text(text)
                    .primaryTextButton()
            }
        )
        .disabled(true)
    }
}

#Preview {
    PrimaryButtonComponentView(
        "Click Me",
        action: { print("Button Clicked") }
    )
}
