//
//  PickerView.swift
//  pick-a-bite-playground
//
//  Created by Abimanyu Damarjati on 20/03/25.
//

import SwiftUI

struct PickerView: View {
    let items: [String]
    let indexedRepeatedItems: [(id: Int, value: String)]
    @State private var currentIndex: Int
    
    init() {
        self.items = ["% Arabica",
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
        let repeatedItems = Array(repeating: self.items, count: 30).flatMap { $0 }
        self.indexedRepeatedItems = repeatedItems.enumerated().map {
            (index, value) in
            (id: index, value: value)
        }
        
        self.currentIndex = self.indexedRepeatedItems.count / 2
    }
    
    
    
    var body: some View {
        VStack {
            Picker ("Test", selection: $currentIndex ) {
                ForEach(indexedRepeatedItems, id: \.id) { (id, value) in
                    Text("\(value)")
                }
            }
            .pickerStyle(WheelPickerStyle())
            .onChange(of: currentIndex) {
                valueChanged(currentIndex)
            }
            Text("Current Index: \(currentIndex)")
            Text("Selection: \(items[currentIndex % items.count])")
        }
    }
    
    func valueChanged(_ value: Int) {
        currentIndex = (indexedRepeatedItems.count / 2) + value % items.count
    }
}

#Preview {
    PickerView()
}
