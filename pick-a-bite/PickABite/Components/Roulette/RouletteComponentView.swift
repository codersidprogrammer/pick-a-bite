//
//  RouletteComponentView.swift
//  PickABite
//
//  Created by Dimaseditiya on 27/03/25.
//

import SwiftUI

struct RouletteComponentView: View {
    
    @StateObject var controller: RouletteController
    @State var radius: CGFloat = 0
    
    var body: some View {
        VStack{
            Spacer()
            Image("arrow")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
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
                            
                            
                            Text(data.description)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .foregroundStyle(.white)
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
                        .foregroundStyle(Color.white)
                        .frame(width: 48, height: 48)
                        .onAppear(){
                            let midX  = geometry.frame(in: .local).midX + 40
                            let midY = geometry.frame(in: .local).midY + 40
                            
                            radius = min(midX, midY)
                        }
                }
            }
            
            Spacer()
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
            color: Color.random(),
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
