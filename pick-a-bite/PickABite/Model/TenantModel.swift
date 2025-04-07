//
//  TenantModel.swift
//  PickABite
//
//  Created by Dimaseditiya on 06/04/25.
//
import Foundation
import SwiftData

@Model
final class TenantModel: JSONEncodable {
    
    @Attribute(.unique)
    var id: UUID
    
    var name: String
    var desc: String
    var imagePath: String
    var location: String
    
    init(id: UUID, name: String, desc: String, imagePath: String, location: String) {
        self.id = id
        self.name = name
        self.desc = desc
        self.imagePath = imagePath
        self.location = location
    }
    
    init(name: String = "", desc: String = "", imagePath: String = "", location: String = "") {
        self.id = UUID()
        self.name = name
        self.desc = desc
        self.imagePath = imagePath
        self.location = location
    }
    
    // MARK: - Manual Encodable conformance
    enum CodingKeys: String, CodingKey {
        case id, name, desc, imagePath, location
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(desc, forKey: .desc)
        try container.encode(imagePath, forKey: .imagePath)
        try container.encode(location, forKey: .location)
    }
}
