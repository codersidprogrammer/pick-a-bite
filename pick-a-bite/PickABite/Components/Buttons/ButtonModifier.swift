//
//  ButtonModifier.swift
//  PickABite
//
//  Created by Dimaseditiya on 05/04/25.
//
import SwiftUI

struct PrimaryTextButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: Sizing.xxl)
            .frame(maxWidth: .infinity)
            .background(Color.primary)
            .cornerRadius(Sizing.sm)
            .padding(.horizontal)
    }
}

extension View {
    public func primaryTextButton() -> some View {
        modifier(PrimaryTextButtonModifier())
    }
}
