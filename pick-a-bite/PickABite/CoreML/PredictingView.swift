//
//  PredictingView.swift
//  kemekuy
//
//  Created by Dimaseditiya on 26/03/25.
//

import SwiftUI

struct PredictingView: View {
    
    @State var predicts: [String:Double] = [:]
    let service: MainPredictService = MainPredictService()
    
    var body: some View {
        List(
            predicts.sorted(by: { $0.value > $1.value}), id: \.key
        ) { key, value in
            HStack {
                Text(key)
                Spacer()
                Text(String(format: "%.2f", value * 100))
            }
        }
        Button(
            action: {
                let jsonDict: [String: Any] = [
//                    "Coffee_Tea": 1,
                    "Juice_Beverages": 1,
//                    "Meat_Protein": 1
                ]
                
                if let preferences = PreferenceDto.fromJson(jsonDict) {
                    print(preferences)
                } else {
                    Logger.error("Failed to parse JSON")
                }
                
                predicts = service.predict(
                    preferences: PreferenceDto.fromJson(jsonDict) ?? PreferenceDto()
                )
            },
            label: {
                Text("Predict")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 48) // This was Sizing.xxl
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "#973131")) // This was Color.primary
                    .cornerRadius(8) // This was Sizing.sm
                    .padding(.horizontal)
            }
        )
    }
}

#Preview {
    PredictingView()
}
