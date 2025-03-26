//
//  PreferenceDto.swift
//  kemekuy
//
//  Created by Dimaseditiya on 26/03/25.
//
import Foundation

struct PreferenceDto: Codable {
    var Coffee_Tea: Int64
    var Sweet_Desserts: Int64
    var Juice_Beverages: Int64
    var Healthy_Vegan: Int64
    var Meat_Protein: Int64
    var Seafood: Int64
    var Spicy_Flavors: Int64
    var Comfort_Food: Int64
    var Noodles_Rice: Int64
    var Bakery_Bread: Int64
    var Hangout_Ambience: Int64
    var Alcohol_Bar: Int64
    var Snacks_Appetizers: Int64
    var Lunch_Meal: Int64
    var Soups_Broths: Int64
    var Japanese_Cuisine: Int64
    var Indonesian_Cuisine: Int64
    var Fast_Food: Int64
    var Refreshing_Fresh: Int64
    var Dining_Experience: Int64

    /// Custom decoding to handle missing keys
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        Coffee_Tea = try container.decodeIfPresent(Int64.self, forKey: .Coffee_Tea) ?? 0
        Sweet_Desserts = try container.decodeIfPresent(Int64.self, forKey: .Sweet_Desserts) ?? 0
        Juice_Beverages = try container.decodeIfPresent(Int64.self, forKey: .Juice_Beverages) ?? 0
        Healthy_Vegan = try container.decodeIfPresent(Int64.self, forKey: .Healthy_Vegan) ?? 0
        Meat_Protein = try container.decodeIfPresent(Int64.self, forKey: .Meat_Protein) ?? 0
        Seafood = try container.decodeIfPresent(Int64.self, forKey: .Seafood) ?? 0
        Spicy_Flavors = try container.decodeIfPresent(Int64.self, forKey: .Spicy_Flavors) ?? 0
        Comfort_Food = try container.decodeIfPresent(Int64.self, forKey: .Comfort_Food) ?? 0
        Noodles_Rice = try container.decodeIfPresent(Int64.self, forKey: .Noodles_Rice) ?? 0
        Bakery_Bread = try container.decodeIfPresent(Int64.self, forKey: .Bakery_Bread) ?? 0
        Hangout_Ambience = try container.decodeIfPresent(Int64.self, forKey: .Hangout_Ambience) ?? 0
        Alcohol_Bar = try container.decodeIfPresent(Int64.self, forKey: .Alcohol_Bar) ?? 0
        Snacks_Appetizers = try container.decodeIfPresent(Int64.self, forKey: .Snacks_Appetizers) ?? 0
        Lunch_Meal = try container.decodeIfPresent(Int64.self, forKey: .Lunch_Meal) ?? 0
        Soups_Broths = try container.decodeIfPresent(Int64.self, forKey: .Soups_Broths) ?? 0
        Japanese_Cuisine = try container.decodeIfPresent(Int64.self, forKey: .Japanese_Cuisine) ?? 0
        Indonesian_Cuisine = try container.decodeIfPresent(Int64.self, forKey: .Indonesian_Cuisine) ?? 0
        Fast_Food = try container.decodeIfPresent(Int64.self, forKey: .Fast_Food) ?? 0
        Refreshing_Fresh = try container.decodeIfPresent(Int64.self, forKey: .Refreshing_Fresh) ?? 0
        Dining_Experience = try container.decodeIfPresent(Int64.self, forKey: .Dining_Experience) ?? 0
    }

    /// Converts a JSON dictionary into a `PreferenceDto`
    static func fromJson(_ dictionary: [String: Any]) -> PreferenceDto? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary)
            return try JSONDecoder().decode(PreferenceDto.self, from: jsonData)
        } catch {
            print("❌ JSON Parsing Error: \(error.localizedDescription)")
            return nil
        }
    }
}

extension PreferenceDto {
    init() {
        self.Coffee_Tea = 0
        self.Sweet_Desserts = 0
        self.Juice_Beverages = 0
        self.Healthy_Vegan = 0
        self.Meat_Protein = 0
        self.Seafood = 0
        self.Spicy_Flavors = 0
        self.Comfort_Food = 0
        self.Noodles_Rice = 0
        self.Bakery_Bread = 0
        self.Hangout_Ambience = 0
        self.Alcohol_Bar = 0
        self.Snacks_Appetizers = 0
        self.Lunch_Meal = 0
        self.Soups_Broths = 0
        self.Japanese_Cuisine = 0
        self.Indonesian_Cuisine = 0
        self.Fast_Food = 0
        self.Refreshing_Fresh = 0
        self.Dining_Experience = 0
    }
}
