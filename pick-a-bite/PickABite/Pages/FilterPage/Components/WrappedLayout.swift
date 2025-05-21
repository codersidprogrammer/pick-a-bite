//
//  WrappedHStack.swift
//  PickABite
//
//  Created by Abimanyu Damarjati on 26/03/25.
//

import SwiftUI

struct WrappedLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        let initialWidth = proposal.replacingUnspecifiedDimensions().width
        let initialHeight = proposal.replacingUnspecifiedDimensions().height
       
        return CGSize(width: initialWidth, height: initialHeight)
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) {
        let lines = groupWrappedLines(in: bounds, proposal, subviews).lines

        // Place subviews with center alignment per line
        var y = bounds.minY
        for line in lines {
            let lineWidth = line.reduce(0) { $0 + $1.sizeThatFits(proposal).width } + CGFloat(
                line.count - 1
            ) * spacing
            var x = bounds.minX + (
                bounds.width - lineWidth
            ) / 2  // Center horizontally

            var maxHeight: CGFloat = 0
            for subview in line {
                let subviewSize = subview.sizeThatFits(proposal)
                subview
                    .place(
                        at: CGPoint(x: x, y: y),
                        proposal: ProposedViewSize(subviewSize)
                    )
                x += subviewSize.width + spacing
                maxHeight = max(maxHeight, subviewSize.height)
            }
            y += maxHeight + spacing
        }
    }
    
    func groupWrappedLines(
        in bounds: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0),
        _ proposal: ProposedViewSize,
        _ subviews: Subviews)
    -> (
        lines: [[LayoutSubviews.Element]],
        height: CGFloat
    ) {
        var lines: [[LayoutSubviews.Element]] = []
        var currentLine: [LayoutSubviews.Element] = []
        var x: CGFloat = 0
        var y: CGFloat = bounds.minY
        var currentLineHeight: CGFloat = 0
        var totalLineHeight: CGFloat = 0
        
        // Group subviews into wrapped lines
        for subview in subviews {
            let subviewSize = subview.sizeThatFits(proposal)
            
            if x + subviewSize.width > bounds.maxX, !currentLine.isEmpty {
                lines.append(currentLine)
                currentLine = []
                x = 0
                y += currentLineHeight + spacing
                currentLineHeight = 0
            }

            currentLine.append(subview)
            x += subviewSize.width + spacing
            
            if currentLineHeight < subviewSize.height {
                currentLineHeight = subviewSize.height
                totalLineHeight += currentLineHeight
            }
        }
        
        // After last iteration
        if !currentLine.isEmpty {
            lines.append(currentLine)
        }
        
        return ( lines, totalLineHeight )
    }
}
