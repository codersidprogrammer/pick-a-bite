//
//  RouletteService.swift
//  PickABite
//
//  Created by Dimaseditiya on 05/04/25.
//

import SwiftUI

@MainActor
class RoulettePageViewModel<R: RepositoryProtocol>: ObservableObject where R.EntityModel == UserHistoryModel {
    let service: MainPredictService = MainPredictService()
    var userHistoryRepo: R
    
    init(repository: R) {
        self.userHistoryRepo = repository
    }
    
    func predictAsSegmentData(preffs: [String] = ["Coffee_Tea","Seafood"]) -> [SegmentData] {
        let jsonDict = Dictionary(uniqueKeysWithValues: preffs.map { value in (value, 1) })
        Logger.log(dictionary: jsonDict)
        
        let preferences = PreferenceDto.fromJson(jsonDict) ?? PreferenceDto()
        let _predicts = service.predict(
            preferences: preferences
        )
        
        return _predicts
            .sorted(by: { $0.value > $1.value })
            .prefix(10)
            .shuffled()
            .enumerated()
            .map { index, elements in
                let (key, value) = elements
                let isEven = index % 2 == 0
                let segment = SegmentData(
                    index: value,
                    color: isEven ? Color.papayaWhip : Color.vividTangelo.opacity(1),
                    description: key
                )
                return segment
            }
    }
}
