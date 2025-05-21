//
//  WidgetPredictServie.swift
//  PickABite
//
//  Created by Dimaseditiya on 16/05/25.
//

final class WidgetPredictService {
    private lazy var model: FeaturesWidgetModelLatest = {
            do {
                return try FeaturesWidgetModelLatest(configuration: .init())
            } catch {
                // TODO: Make return nil or something rather tah fatalError
                fatalError("Failed to load model: \(error)")
            }
    }()
    
    func predict(preferences: FeatureDto) -> [String: Double] {
        do {
            let input = FeaturesWidgetModelLatestInput(Temperature: preferences.temperature, Humidity: preferences.humidity)
            
            let output = try model.prediction(input: input)
            return output.Combined_CategoriesProbability
        } catch let err {
            print(err.localizedDescription)
            return [:]
        }
    }
}
