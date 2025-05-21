//
//  FeatureDto.swift
//  PickABite
//
//  Created by Dimaseditiya on 16/05/25.
//

import Foundation

struct FeatureDto: Codable {
    var temperature: Int64
    var humidity: Int64

    /// Custom decoding to handle missing keys
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        temperature = try container.decodeIfPresent(Int64.self, forKey: .temperature) ?? 0
        humidity = try container.decodeIfPresent(Int64.self, forKey: .humidity) ?? 0
    }
    
    init(temp temperature: Int64, humid humidity: Int64) {
        self.temperature = temperature
        self.humidity = humidity
    }

    /// Converts a JSON dictionary into a `PreferenceDto`
    static func fromJson(_ dictionary: [String: Any]) -> FeatureDto? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary)
            return try JSONDecoder().decode(FeatureDto.self, from: jsonData)
        } catch {
            print("❌ JSON Parsing Error: \(error.localizedDescription)")
            return nil
        }
    }
}

extension FeatureDto {
    init() {
        self.temperature = 25
        self.humidity = 60
    }
    
    func toJsonString() -> String {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            do {
                let data = try encoder.encode(self)
                return String(data: data, encoding: .utf8) ?? "{}"
            } catch {
                return "{}"
            }
        }
}

extension FeatureDto: CustomStringConvertible {
    var description: String {
        return """
        FeatureDto(
            temperature: \(temperature),
            humidity: \(humidity),
        )
        """
    }
}


