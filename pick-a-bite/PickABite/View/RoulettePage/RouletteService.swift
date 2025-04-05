//
//  RouletteService.swift
//  PickABite
//
//  Created by Dimaseditiya on 05/04/25.
//

import SwiftUI

class RoulettePageService: ObservableObject {
    let service: MainPredictService = MainPredictService()
    
    func predictAsSegmentData() -> [SegmentData] {
        let jsonDict: [String: Any] = [
                        "Coffee_Tea": 1,
//            "Seafood": 1,
//                        "Juice_Beverages": 1,
//                        "Meat_Protein": 1
        ]
        
        let preferences = PreferenceDto.fromJson(jsonDict) ?? PreferenceDto()
        let _predicts = service.predict(
            preferences: preferences
        )
        
//        Logger.log(dictionary: _predicts)
        
        return _predicts
            .sorted(by: { $0.value > $1.value })
            .prefix(10)
            .enumerated()
            .map { index, elements in
                let (key, value) = elements
                let isEven = index % 2 == 0
                let segment = SegmentData(
                    index: value,
                    color: isEven ? Color.primary : Color.secondary,
                    description: key
                )
                return segment
            }
    }
}
