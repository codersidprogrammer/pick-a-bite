//
//  CardMediaNetworkComponentView.swift
//  PickABite
//
//  Created by Dimaseditiya on 17/05/25.
//

import SwiftUI

struct CardMediaNetworkComponentView: View {
    
    var imageUrl: String
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .center, spacing: Sizing.lg3) {
            AutoScroller(imageNames: [imageUrl])
            VStack(alignment: .leading) {
                Text(title)
                    .font(.custom("SF Pro", size: Sizing.lg3))
                    .foregroundStyle(.kombuGreen)
                    .fontWeight(.bold)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.kombuGreen)
                    .padding(.bottom, Sizing.md)
            }
            .padding(.top, Sizing.xl2)
            .padding(.horizontal, Sizing.md)
        }
    }
}

#Preview {
    CardMediaNetworkComponentView(
        imageUrl: "https://thebreeze.bsdcity.com/wp-content/uploads/2023/02/CROCO.jpg",
        title: "FORE Coffee",
        subtitle: "Established in 2018, Fore Coffee is a passionate coffee startups aiming to brew the best specialty coffee for our customer. As our name derived from the word forest, we aim to grow fast, strong, tall and bring life to our surrounding. We want our existence to increase coffee quality for our community. Leveraging network and experience, we are using the latest tech for our tools and bean blend. Directly from the selected farmer, high-quality beans are processed and roasted to perfection by ourselves then passed on to our skilled barista, excitedly prepare the cup of happiness to be served to you especially."
    )
}


//"https://thebreeze.bsdcity.com/wp-content/uploads/2024/11/Arabica-01.jpg",
//"https://thebreeze.bsdcity.com/wp-content/uploads/2024/02/AUNTIE-ANNES.jpg",
//"https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/BEBEK-BENGIL-1.jpg",
//"https://thebreeze.bsdcity.com/wp-content/uploads/2023/04/BOOST-JUICE-BAR-1.jpg",
//"https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/BREWERKZ.jpg"
