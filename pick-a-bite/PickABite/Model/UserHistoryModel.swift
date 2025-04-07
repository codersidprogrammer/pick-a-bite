//
//  UserHistoryModel.swift
//  PickABite
//
//  Created by Dimaseditiya on 06/04/25.
//
import Foundation
import SwiftData

@Model
final class UserHistoryModel: JSONEncodable {
    @Attribute(.unique)
    var id: UUID
    
    var tenantName: String
    var criteria: [String]
    var spinSequence: Int
    var createdAt: Date
    
    init(
        id: UUID = UUID(),
        tenantName: String,
        criteria: [String],
        spinSequence: Int,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.tenantName = tenantName
        self.criteria = criteria
        self.spinSequence = spinSequence
        self.createdAt = createdAt
    }
    
    // MARK: - CodingKeys for manual Codable conformance
    enum CodingKeys: String, CodingKey {
        case id
        case tenantName
        case criteria
        case spinSequence
        case createdAt
    }
    
    // MARK: - Encode
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(tenantName, forKey: .tenantName)
        try container.encode(criteria, forKey: .criteria)
        try container.encode(spinSequence, forKey: .spinSequence)
        try container.encode(createdAt, forKey: .createdAt)
    }
}
