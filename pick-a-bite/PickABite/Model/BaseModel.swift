//
//  BaseModel.swift
//  PickABite
//
//  Created by Dimaseditiya on 06/04/25.
//
import Foundation


protocol JSONEncodable: Encodable {
    func toJsonString(pretty: Bool) -> String?
}

extension JSONEncodable {
    func toJsonString(pretty: Bool = false) -> String? {
        let encoder = JSONEncoder()
        if pretty {
            encoder.outputFormatting = .prettyPrinted
        }
        do {
            let data = try encoder.encode(self)
            return String(data: data, encoding: .utf8)
        } catch {
            print("❌ Encoding error: \(error)")
            return nil
        }
    }
}
