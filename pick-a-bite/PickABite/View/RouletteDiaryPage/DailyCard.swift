//
//  DailyCard.swift
//  PickABite
//
//  Created by Aristo Yongka on 07/04/25.
//

import SwiftUI

struct DailyCard: View {
    @Binding var isPresented: Bool

    var body: some View {
        Button {
            // Tindakan saat card ditekan
        } label: {
            VStack(spacing: 0) {
                HStack {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Selasa, 12 Maret 2025")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.black)

                        ZStack(alignment: .trailing) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(0..<6, id: \.self) { _ in
                                        CloudTag()
                                    }
                                }
                            }

                            LinearGradient(
                                gradient: Gradient(colors: [Color.clear, Color.white]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .frame(width: 50, height: 31)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }

                    Button {
                        isPresented = true
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                    }
                }
                .background(Color.white)
                .padding(.vertical, 16)

                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    DailyCard(isPresented: .constant(false))
}
