//
//  BasicCarousel.swift
//  PickABite
//
//  Created by Dimaseditiya on 17/05/25.
//

import SwiftUI

// Step 1: Create a SwiftUI ContentView
struct ContentView: View {
    var body: some View {
        AutoScroller(imageNames: ["uk", "us", "germany", "italy", "russia", "spain", "estonia"])
    }
}

// Step 2: Define the AutoScroller View
struct AutoScroller: View {
    var imageNames: [String]
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    // Step 3: Manage Selected Image Index
    @State private var selectedImageIndex: Int = 0

    var body: some View {
        ZStack {
            // Step 4: Background Color
//            Color.secondary
//                .ignoresSafeArea()

            // Step 5: Create TabView for Carousel
            TabView(selection: $selectedImageIndex) {
                // Step 6: Iterate Through Images
                ForEach(0..<imageNames.count, id: \.self) { index in
                    ZStack(alignment: .topLeading) {
                        AsyncImage(url: URL(string: imageNames[index])!) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(RoundedRectangle(cornerRadius: Sizing.sm))
                                    .padding(.horizontal, Sizing.lg3)
                            
                            case .failure(let error):
                                
                                Text("Failed to load image: \(error.localizedDescription)") // Error handling
                                
                            @unknown default:
                                EmptyView()
                            }
                        }

                    }
                    .padding(.horizontal, Sizing.md)
//                    .background(VisualEffectBlur()) // Step 8: Apply Visual Effect Blur
//                    .shadow(radius: 20) // Step 9: Apply Shadow
                }
            }
            .frame(height: 300) // Step 10: Set Carousel Height
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Step 11: Customize TabView Style
            .ignoresSafeArea()

            // Step 12: Navigation Dots
            HStack {
                ForEach(0..<imageNames.count, id: \.self) { index in
                    // Step 13: Create Navigation Dots
                    Capsule()
                        .fill(Color.black.opacity(selectedImageIndex == index ? 0.6 : 0.33))
                        .frame(width: 35, height: 8)
                        .onTapGesture {
                            // Step 14: Handle Navigation Dot Taps
                            selectedImageIndex = index
                        }
                }
                .offset(y: 130) // Step 15: Adjust Dots Position
            }
            .padding(.top, Sizing.xl3)
        }
        .onReceive(timer) { _ in
            // Step 16: Auto-Scrolling Logic
            withAnimation(.default) {
                selectedImageIndex = (selectedImageIndex + 1) % imageNames.count
            }
        }
    }
}

#Preview {
    
    AutoScroller(imageNames: ["https://thebreeze.bsdcity.com/wp-content/uploads/2024/11/Arabica-01.jpg",
                              "https://thebreeze.bsdcity.com/wp-content/uploads/2024/02/AUNTIE-ANNES.jpg",
                              "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/BEBEK-BENGIL-1.jpg",
                              "https://thebreeze.bsdcity.com/wp-content/uploads/2023/04/BOOST-JUICE-BAR-1.jpg",
                              "https://thebreeze.bsdcity.com/wp-content/uploads/2021/11/BREWERKZ.jpg"])
}
