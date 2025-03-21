//
//  Item.swift
//  pick-a-bite-playground
//
//  Created by Abimanyu Damarjati on 19/03/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    var id: String
    
    init(timestamp: Date) {
        self.timestamp = timestamp
        self.id = UUID().uuidString
    }
}
