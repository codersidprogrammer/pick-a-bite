////
////  ContentView.swift
////  PickABite
////
////  Created by Abimanyu Damarjati on 25/03/25.
////
//
import SwiftUI

struct ContentView: View {
    private let now = Date.now
    
    var body: some View {
        NavigationStack {
            FilterView()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            VStack (alignment: .leading) {
                                Text(
                                    now,
                                    format: .dateTime.day().month(.wide).year()
                                )
                                .font(.caption)
                                .textCase(.uppercase)
                                .foregroundStyle(.secondary)
                                Text(now, format: .dateTime.weekday(.wide))
                                    .font(.headline).textCase(.uppercase)
                            }
                            Spacer()
                            Button {
                                        
                            } label: {
                                Image(
                                    systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90"
                                )
                            }
                        }.padding()
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
