//
//  RouletteComponentView.swift
//  PickABite
//
//  Created by Dimaseditiya on 27/03/25.
//

import SwiftUI

struct SouthTriangle: Shape {
    func path(in rect: CGRect) -> Path {
            var path = Path()

            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = min(rect.width, rect.height) / 2

            // Points on a circle (in radians): top left, top right, bottom (facing south)
            let angleOffset = -CGFloat.pi / 2 // Start pointing up, then rotate

            let p1 = CGPoint(
                x: center.x + radius * cos(angleOffset + .pi / 6),
                y: center.y + radius * sin(angleOffset + .pi / 6)
            )

            let p2 = CGPoint(
                x: center.x + radius * cos(angleOffset - .pi / 6),
                y: center.y + radius * sin(angleOffset - .pi / 6)
            )

            let p3 = CGPoint(
                x: center.x + radius * cos(angleOffset + .pi),
                y: center.y + radius * sin(angleOffset + .pi)
            )

            path.move(to: p1)
            path.addLine(to: p2)
            path.addLine(to: p3)
            path.closeSubpath()

            return path
        }
}

struct RouletteComponentView: View {
    
    @StateObject var controller: RouletteController
    @State var radius: CGFloat = 0
    
    var body: some View {
        VStack{
            Spacer()
            GeometryReader{ geometry in
                ZStack{
                    
                    ForEach(Array(controller.segmentData.enumerated()), id: \.element.index) { index, data in
                        ZStack{
                            SegmentShape(
                                startAngle: angleForSegment(index),
                                endAngle: angleForSegment(index + 1)
                            )
                            .foregroundStyle(data.color)
                            .onAppear(){
                                let midX  = geometry.frame(in: .local).midX + 40
                                let midY = geometry.frame(in: .local).midY + 40
                                
                                radius = min(midX, midY)
                            }
                            
                            
                            Text(data.description.count > 10 ? "\(data.description.prefix(10)).." : data.description)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .foregroundStyle(data.color == Color.papayaWhip ? Color.kombuGreen : Color.cosmicLatte)
                                .fontWeight(.semibold)
                                .rotationEffect(
                                    angleForSegment(index) - Angle(degrees: 160),
                                    anchor: .center
                                )
                                .offset(
                                    CGSize(
                                        width: { () -> Double in
                                            let mean: Angle = (angleForSegment(index) + angleForSegment(index + 1)) / 2
                                            return radius * 0.5 * cos(mean.radians)
                                        }(),
                                        height: { () -> Double in
                                            let mean: Angle = (angleForSegment(index) + angleForSegment(index + 1)) / 2
                                            
                                            return radius * 0.5 * sin(mean.radians)
                                        }()
                                    )
                                )
                        }
                        .rotationEffect(.degrees(controller.rotation))
                    }
                    
                    Circle()
                        .foregroundStyle(Color.kombuGreen)
                        .frame(width: 48, height: 48)
                        .onAppear(){
                            let midX  = geometry.frame(in: .local).midX + 40
                            let midY = geometry.frame(in: .local).midY + 40
                            
                            radius = min(midX, midY)
                        }
                }
            }
            SouthTriangle()
                .fill(Color.kombuGreen)
                .frame(width: 150, height: 75)
                .offset(x: 0, y: -420)
            
        }
    }
    
    func angleForSegment(_ index: Int) -> Angle {
        return Angle(degrees: Double(index) / Double(controller.segmentData.count) * 360)
    }
}

#Preview {
    @Previewable @State var sectorsData: [SegmentData] = [
        SegmentData(
            index: Double.random(in: 0...1),
            color: Color.random(),
            description: "Long title here"
        ),
        SegmentData(
            index: Double.random(in: 0...1),
            color: Color.random(),
            description: "String 2"
        ),
        SegmentData(
            index: Double.random(in: 0...1),
            color: Color.random(),
            description: "String 3"
        ),
        SegmentData(
            index: Double.random(in: 0...1),
            color: Color.vividTangelo,
            description: "String 4"
        ),
        SegmentData(
            index: Double.random(in: 0...1),
            color: Color.random(),
            description: "String 5"
        ),
        SegmentData(
            index: Double.random(in: 0...1),
            color: Color.random(),
            description: "String 65656"
        ),
        SegmentData(
            index: Double.random(in: 0...1),
            color: Color.random(),
            description: "String 7"
        ),
        SegmentData(
            index: Double.random(in: 0...1),
            color: Color.random(),
            description: "String 8"
        ),
        SegmentData(
            index: Double.random(in: 0...1),
            color: Color.random(),
            description: "String 9"
        ),
        SegmentData(
            index: Double.random(in: 0...1),
            color: Color.random(),
            description: "String 10"
        ),
    ]
    
    let controller = RouletteController(segmentData: sectorsData)
    RouletteComponentView(controller: controller)
        .padding(.horizontal, Sizing.md)
        .onTapGesture{
            controller.spin()
        }
}
