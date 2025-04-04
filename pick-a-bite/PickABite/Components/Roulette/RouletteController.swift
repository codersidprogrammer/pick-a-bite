//
//  RouletteController.swift
//  PickABite
//
//  Created by Dimaseditiya on 03/04/25.
//

import SwiftUI

class RouletteController: ObservableObject {
    @Published var segmentData: [SegmentData] = []
    @Published var rotation: Double = 0
    @Published var selectedSegment: SegmentData
    @Published var isSelected: Bool = false
    
    var isSpinning: Bool = false
    let totalSpinDuration: Double = 5.0
    var totalRotation: Double = 3500
    var names: [String] = [""]
    var winningColor: [String] = [""]
    var winningValue: String = ""
    
    init(segmentData: [SegmentData]) {
        self.segmentData = segmentData
        self.selectedSegment = SegmentData(index: 0, color: Color.white, description: "")
    }
    
    func setSegment(data: [SegmentData]) {
        if segmentData.count != 0 {
            Logger.log("Resetting list")
            segmentData.removeAll()
        }
        segmentData = data
    }
    
    func spin() {
        guard !isSpinning else { return }
        
        isSpinning = true
        isSelected = false
        
        withAnimation(Animation.timingCurve(0.1, 0.8, 0.3, 1.0, duration: totalSpinDuration)) {
            rotation += totalRotation
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + totalSpinDuration) { [weak self] in
            guard let this = self else { return }
            
            this.isSpinning = false
            let incompleteRotation = (Int(this.rotation) + 90) % 360
            let restOfRotation: Double = Double(incompleteRotation) / (360.0 / Double(this.segmentData.count))
            let restOfRotationInteger = Int(restOfRotation)
            let winningIndex = Int(round(restOfRotation))
            let selected = this.segmentData.reversed()
            
            let winnerIndex = selected.index(selected.startIndex, offsetBy: this.constrain(winningIndex, min: 0, max: this.segmentData.count - 1))
            let winner = selected[winnerIndex]
            Logger.log("rotation: \(this.rotation) incompleteRotation: \(incompleteRotation) totalRotation: \(this.totalRotation)")
            Logger.log("restOfRotation: \(restOfRotation) restOfRotationInteger: \(restOfRotationInteger) winningIndexModulo: \(restOfRotationInteger % this.segmentData.count)")
            Logger.log("winningIndex: \(winningIndex) winnerIndex: \(winnerIndex)")
            Logger.log(winner.description)
            Logger.log("-------------------------")
            this.selectedSegment = winner
            this.isSelected = true
        }
    }
    
    func constrain(_ value: Int, min: Int, max: Int) -> Int {
        return value < min ? min : value > max ? max : value
    }
}
