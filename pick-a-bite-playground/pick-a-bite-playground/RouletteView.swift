//
//  RouletteView.swift
//  pick-a-bite-playground
//
//  Created by Abimanyu Damarjati on 20/03/25.
//

import SwiftUI

struct RouletteView: View {
    @State private var radius: CGFloat = 0
    @StateObject var viewModel: RouletteViewModel = .init()
    @FocusState private var focusedField: Bool
    
    init() {
        let _ = ["% Arabica",
                 "AUNTIE ANNE’S",
                 "Bebek Bengil",
                 "BOOST JUICE BAR",
                 "Brewerkz",
                 "Burgreens",
                 "Chakra Hall",
                 "CHATERAISE",
                 "Chatime",
                 "CHONG QING HOT POT",
                 "Colico",
                 "CROCO",
                 "Cut & Grill",
                 "D’COST",
                 "DORE by LeTAO",
                 "Dum Dum Thai Tea",
                 "Fire Prawn",
                 "Fore Coffee",
                 "FRUITY JUICE",
                 "GALLURA",
                 "GINDACO",
                 "Gion",
                 "Gubug Makan Mang Engking",
                 "Hachi Grill",
                 "Han Guksu",
                 "Honu",
                 "Ikkudo Ichi",
                 "J.CO Donut & Coffee",
                 "Jalarasa",
                 "Jittlada",
                 "Katsukita",
                 "KITCHENETTE",
                 "Kumulo",
                 "LEKO",
                 "MARUGAME UDON",
                 "Montato",
                 "NOB Bakery",
                 "Old Town Coffee",
                 "PAUL LE CAFE",
                 "REJUVE",
                 "SAIGON DELIGHT",
                 "SAKE BIRU",
                 "Salad Stop",
                 "Shihlin",
                 "SINAMON",
                 "SOUR SALLY",
                 "Starbucks",
                 "Subway",
                 "Sushi Tei",
                 "TAMPER COFFEE",
                 "THE PANCAKE CO.",
                 "THE PEOPLE’S CAFE",
                 "VILLA CAPRI",
                 "VIVOLI GELATO",
                 "Wee Nam Kee"]
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    ForEach(0..<viewModel.segmentCount, id: \.self) { index in
                        ZStack {
                            Segment(
                                startAngle: self.angleForSegment(index),
                                endAngle: self.angleForSegment(index + 1))
                            .foregroundStyle(viewModel.colors[index % viewModel.colors.count])
                            .onAppear() {
                                let midX  = geometry.frame(in: .local).midX + 40
                                let midY = geometry.frame(in: .local).midY + 40
                                
                                radius = min(midX, midY)
                            }
                            Text(viewModel.names[index])
                                .foregroundStyle(.white)
                                .font(.headline)
                                .rotationEffect(angleForSegment(index + 1) - Angle(degrees: 10))
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
                        .frame(width: 300, height: 300)
                        .rotationEffect(.degrees(viewModel.rotation))
                    }
                    Circle()
                        .foregroundStyle(.white)
                        .frame(width: 50, height: 50)
                    //                    Arrow()
                    //                        .foregroundStyle(.gray)
                    //                        .frame(width: 30, height: 30, alignment: .center)
                    //                        .rotationEffect(.degrees(180))
                    //                        .offset()
                    
                }
                .onTapGesture {
                    viewModel.spin()
                }
            }
            .frame(width: 300)
            Spacer()
            VStack(spacing: 10) {
                HStack {
                    TextField("Enter name", text: $viewModel.newColorName)
                        .padding(.leading)
                        .frame(height: 55)
                        .focused($focusedField)
                        .background(.thinMaterial)
                    Button(action: {
                        viewModel.addNewItem()
                        focusedField = false
                    }, label: {
                        Text("Add")
                            .bold()
                            .frame(width: 80, height: 55)
                            .background(.thinMaterial, in: .rect(cornerRadius: 12))
                    }).tint(.primary)
                }
                Spacer()
                if viewModel.names.filter({ $0 != "" }).isEmpty == false {
                    List {
                        ForEach(viewModel.names, id: \.self) { name in
                            Text(name)
                        }
                        .onDelete(perform: viewModel.deleteItem)
                    }
                    .listStyle(.grouped)
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .padding(.horizontal, 10)
        .alert("We have a winner!", isPresented: $viewModel.showAlert) {
            
        } message: {
            Text("The winning value is: \(viewModel.winningValue)")
        }
    }
    
    func angleForSegment(_ index: Int) -> Angle {
        Angle(degrees: Double(index) / Double(viewModel.names.count) * 360)
    }
    
    func textAngleForSegmen(_ index: Int) -> Angle {
        let segmentAngle = 360.0 / Double(viewModel.names.count)
        return Angle(degrees: -Double(index) * segmentAngle - segmentAngle / 2)
    }
}

#Preview {
    RouletteView()
}
