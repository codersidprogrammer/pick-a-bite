//
//  Untitled.swift
//  WeSplit
//
//  Created by Aristo Yongka on 06/04/25.
//

import SwiftUI

struct ModalView: View {
    @Binding var isPresented: Bool
    var body: some View {
        VStack(alignment :.leading, spacing: 12) {
            HStack{
                Text("Selasa, 18 Maret 2025")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.black)
                
                Spacer()
                
                Button("Done", role: .cancel) {
                    isPresented = false
                }
                .font(.title3)
                
            }
            
            HStack {
                
            }
            
            Text("1st Spin")
                .font(.subheadline)
                .bold()
                .foregroundColor(.black)
            TenantCard()
            TenantCard()
            Text("2nd Spin")
                .font(.subheadline)
                .bold()
                .foregroundColor(.black)
            TenantCard()
            TenantCard()
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, 30)
        .padding(.vertical, 20)

    }
}

struct TenantCard: View {
    var body: some View {
        HStack(alignment: .center) {
            HStack(alignment: .top, spacing: 15) {
                Image("default_restaurant")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                VStack(alignment: .leading, spacing: 6) {
                    Text("Kantin Kasturi")
                        .bold()
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("GOP 9")
                        Text("\u{2022}")
                        Text("200m")
                    }
                }
            }
            Spacer()
            Image(systemName: "map")
        }
    }
}

#Preview {
    ModalView(isPresented : .constant(true))
}
