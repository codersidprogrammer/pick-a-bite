//
//  ButtonModifier.swift
//  PickABite
//
//  Created by Dimaseditiya on 05/04/25.
//
import SwiftUI

struct PrimaryTextButtonModifier: ViewModifier {
    var isDisabled: Bool = false
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: Sizing.xl)
            .frame(maxWidth: .infinity)
            .background(isDisabled ? Color.gray.opacity(0.3) : Color.primary)
            .cornerRadius(Sizing.sm)
            .padding(.horizontal)
    }
}

extension View {
    public func primaryTextButton(isDisabled: Bool = false) -> some View {
        modifier(PrimaryTextButtonModifier(isDisabled: isDisabled))
    }
}
