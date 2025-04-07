//
//  FoodCategory.swift
//  PickABite
//
//  Created by Abimanyu Damarjati on 26/03/25.
//

import Foundation

struct FoodCategory: Identifiable {
    var id: UUID
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
