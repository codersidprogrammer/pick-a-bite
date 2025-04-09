//
//  DailyCard.swift
//  PickABite
//
//  Created by Aristo Yongka on 07/04/25.
//

import SwiftUI

extension Date {
    func formattedLongDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM yyyy"
        return formatter.string(from: self)
    }
}

struct DailyCard: View {
    @Binding var isPresented: Bool
    var dataModel: UserHistoryModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text(dataModel.createdAt.formattedLongDate())
                        .font(.headline)
                        .bold()
                        .foregroundColor(.black)
                    
                    ZStack(alignment: .trailing) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(dataModel.criteria, id: \.self) { value in
                                    ChipOutlinedComponentView(value)
                                }
                            }
                        }
                        
                        LinearGradient(
                            gradient: Gradient(colors: [Color.clear, Color.cosmicLatte]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(width: 50, height: 31)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .background(Color.clear)
                
                Button {
                    isPresented = true
                    print("Goooodd")
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                }
            }
            .background(Color.cosmicLatte)
            .padding(.vertical, Sizing.md)
        }
    }
}

#Preview {
    DailyCard(isPresented: .constant(false), dataModel: UserHistoryModel.dummy)
}
