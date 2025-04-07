//
//  FoodCategory.swift
//  PickABite
//
//  Created by Abimanyu Damarjati on 26/03/25.
//

import Foundation

struct FoodCategory: Identifiable {
    var id: UUID
    var key: String
    var name: String
    
    init(id: UUID = UUID(), key: String, name: String) {
        self.id = id
        self.key = key
        self.name = name
    }
}
