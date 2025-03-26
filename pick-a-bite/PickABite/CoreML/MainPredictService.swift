//
//  MainPredictService.swift
//  kemekuy
//
//  Created by Dimaseditiya on 26/03/25.
//
import CoreML

final class MainPredictService {
    
    private lazy var model: PreferenceClass = {
            do {
                return try PreferenceClass(configuration: .init())
            } catch {
                // TODO: Make return nil or something rather tah fatalError
                fatalError("Failed to load model: \(error)")
            }
    }()
    
    func predict(preferences: PreferenceDto) -> [String: Double] {
        do {
            let input = PreferenceClassInput(
                Coffee_Tea: preferences.Coffee_Tea,
                Sweet_Desserts: preferences.Sweet_Desserts,
                Juice_Beverages: preferences.Juice_Beverages,
                Healthy_Vegan: preferences.Healthy_Vegan,
                Meat_Protein: preferences.Meat_Protein,
                Seafood: preferences.Seafood,
                Spicy_Flavors: preferences.Spicy_Flavors,
                Comfort_Food: preferences.Comfort_Food,
                Noodles_Rice: preferences.Noodles_Rice,
                Bakery_Bread: preferences.Bakery_Bread,
                Hangout_Ambience: preferences.Hangout_Ambience,
                Alcohol_Bar: preferences.Alcohol_Bar,
                Snacks_Appetizers: preferences.Snacks_Appetizers,
                Lunch_Meal: preferences.Lunch_Meal,
                Soups_Broths: preferences.Soups_Broths,
                Japanese_Cuisine: preferences.Japanese_Cuisine,
                Indonesian_Cuisine: preferences.Indonesian_Cuisine,
                Fast_Food: preferences.Fast_Food,
                Refreshing_Fresh: preferences.Refreshing_Fresh,
                Dining_Experience: preferences.Dining_Experience
            )
            
            let output = try model.prediction(input: input)
            Logger.log("\(output)")
            return output.nameProbability
        } catch let err {
            Logger.error(err.localizedDescription)
            return [:]
        }
    }
}
