//
//  LaunchScreenView.swift
//  PickABite
//
//  Created by Abimanyu Damarjati on 09/04/25.
//


import SwiftUI

struct LaunchScreenView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager // Mark 1

    @State private var firstAnimation = false  // Mark 2
    @State private var secondAnimation = false // Mark 2
    @State private var startFadeoutAnimation = false // Mark 2
    
    @ViewBuilder
    private var image: some View {  // Mark 3
        Image("RouletteBitten")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .rotationEffect(firstAnimation ? Angle(degrees: 720) : Angle(degrees: 0)) // Mark 4
    }
    
    @ViewBuilder
    private var backgroundColor: some View {  // Mark 3
        LinearGradient(colors: [.cosmicLatte, .papayaWhip], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
    }
    
    var body: some View {
        ZStack {
            backgroundColor  // Mark 3
            Image("Ticker")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .offset(y: -38)
                .zIndex(2)
            image  // Mark 3
        }.onAppear() {
            withAnimation(.timingCurve(0.22, 1, 0.36, 1, duration: 1)) {
                firstAnimation.toggle()
                
                withAnimation(.linear.delay(1)) {
                    startFadeoutAnimation = true
                }
            }
        }
        .opacity(startFadeoutAnimation ? 0 : 1)
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenStateManager())
    }
}
