//
//  RouletteViewModel.swift
//  pick-a-bite-playground
//
//  Created by Abimanyu Damarjati on 20/03/25.
//

import Foundation
import SwiftUICore

class RouletteViewModel: ObservableObject {
    @Published var segmentCount: Int = 1
    @Published var rotation: Double = 0
    @Published var isSpinning: Bool = false
    @Published var winningValue: String = ""
    @Published var showAlert: Bool = false
    @Published var usedColor: [Color] = [.blue]
    @Published var colors: [Color] = [.gray.opacity(0.3)]
    @Published var usedColorNames: [Color] = [.blue]
    @Published var names: [String] = [""]
    @Published var winningColor: [String] = [""]
    @Published var newColorName: String = ""
    var selectedColor: Color = .blue
    var lastUsedColor: Color = .clear
    var availableColors: [Color] = [.blue, .red, .yellow, .green, .orange, .purple]
    let totalSpinDuration: Double = 5.0
    var totalRotation: Double = 3500
    
    
    func spin() {
        guard !isSpinning else { return }
        
        isSpinning = true
        
        withAnimation(Animation.timingCurve(0.1, 0.8, 0.3, 1.0, duration: totalSpinDuration)) {
            rotation += totalRotation
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + totalSpinDuration) { [weak self] in
            guard let this = self else { return }
            
            this.isSpinning = false
            let incompleteRotation = Int(this.rotation) % 360
            let restOfRotation: Double = Double(incompleteRotation) / (360.0 / Double(this.segmentCount))
            let restOfRotationInteger = Int(restOfRotation)
            let winningIndex = Double(restOfRotationInteger) == restOfRotation ? restOfRotationInteger : restOfRotationInteger + 1
            this.winningColor = this.names.reversed()
            this.winningValue = this.winningColor[winningIndex - 1]
            this.showAlert = true
        }
    }
    
    func addNewItem() {
        guard !newColorName.isEmpty else { return }
        
        addNewColorAndName(name: newColorName)
        names.removeAll(where: { $0 == "" })
        segmentCount = names.count
        newColorName = ""
    }
    
    func deleteItem(at offsets: IndexSet) {
        names.remove(atOffsets: offsets)
        segmentCount -= 1
        if (names.isEmpty) {
            names = [""]
            segmentCount += 1
        }
    }
    
    func addNewColorAndName(name: String) {
        if (usedColor.count < availableColors.count) {
            let unusedColor = availableColors.filter{ !usedColor.contains($0) }
            if let randomColor = unusedColor.randomElement() {
                colors.append(randomColor)
                usedColor.append(randomColor)
                lastUsedColor = randomColor
                
                if availableColors.firstIndex(of: randomColor) != nil {
                    names.append(name)
                }
            }
        } else {
            if let randomColor = availableColors.filter({ $0 != lastUsedColor && $0 != colors[0] }).randomElement() {
                colors.append(randomColor)
                lastUsedColor = randomColor
                if availableColors.firstIndex(of: randomColor) != nil {
                    names.append(name)
                }
            }
        }
    }
}
