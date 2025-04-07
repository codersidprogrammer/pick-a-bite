//
//  CloudTag.swift
//  PickABite
//
//  Created by Aristo Yongka on 07/04/25.
//

import SwiftUI

struct CloudTag: View {
    var body: some View {
        HStack {
            Image(systemName: "flame.fill")
                .foregroundColor(.black)
            Text("Flavor")
                .foregroundColor(.black)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}


#Preview {
    CloudTag()
}
