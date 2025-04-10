//
//  RouletteController.swift
//  PickABite
//
//  Created by Dimaseditiya on 03/04/25.
//

import SwiftUI
import UIKit

class RouletteController: ObservableObject {
    @Published var segmentData: [SegmentData] = []
    @Published var rotation: Double = 0
    @Published var selectedSegment: SegmentData
    @Published var isSelected: Bool = false
    @Published var countChances: Int = 0
    @Published var havingChance: Bool = true
    
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
        segmentData.removeAll()
        segmentData = data
    }
    
    func spin() {
        guard countChances != 3 else {
            Logger.error("Count is limited: \(countChances)")
            havingChance = false
            return
        }
        guard !isSpinning else { return }
        
        isSpinning = true
        isSelected = false
        self.countChances += 1
        
        withAnimation(Animation.timingCurve(0.1, 0.8, 0.3, 1.0, duration: totalSpinDuration)) {
            rotation += totalRotation
        }
        
        let steps = 20
        for i in 0..<steps {
            let t = Double(i) / Double(steps)
            let easedT = cubicBezierEase(t, p0: 0.1, p1: 0.8, p2: 0.3, p3: 1.0)
            let triggerTime = easedT * totalSpinDuration

            // Scale haptic strength based on progress
            let style: UIImpactFeedbackGenerator.FeedbackStyle
            switch easedT {
            case 0..<0.33:
                style = .light
            case 0.33..<0.66:
                style = .medium
            default:
                style = .heavy
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + triggerTime) {
                let generator = UIImpactFeedbackGenerator(style: style)
                generator.prepare()
                generator.impactOccurred()
            }
        }

        
        DispatchQueue.main.asyncAfter(deadline: .now() + totalSpinDuration) { [weak self] in
            guard let this = self else { return }
            
            this.isSpinning = false
            let incompleteRotation = (Int(this.rotation) + 90) % 360
            let restOfRotation: Double = Double(incompleteRotation) / (360.0 / Double(this.segmentData.count))
            _ = Int(restOfRotation)
            let winningIndex = Int(round(restOfRotation))
            let selected = this.segmentData.reversed()
            
            let winnerIndex = selected.index(selected.startIndex, offsetBy: this.constrain(winningIndex, min: 0, max: this.segmentData.count - 1))
            let winner = selected[winnerIndex]
            
            this.selectedSegment = winner
            this.isSelected = true
        }
    }
    
    func constrain(_ value: Int, min: Int, max: Int) -> Int {
        return value < min ? min : value > max ? max : value
    }
    
    func cubicBezierEase(_ t: Double, p0: Double, p1: Double, p2: Double, p3: Double) -> Double {
        let u = 1 - t
        let tt = t * t
        let uu = u * u
        let uuu = uu * u
        let ttt = tt * t

        return (uuu * p0) + (3 * uu * t * p1) + (3 * u * tt * p2) + (ttt * p3)
    }
}
