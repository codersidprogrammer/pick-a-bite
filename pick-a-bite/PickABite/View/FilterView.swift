//
//  FilterView.swift
//  PickABite
//
//  Created by Abimanyu Damarjati on 25/03/25.
//

import SwiftUI

struct FilterView: View {
    
    // NOTE (Dimas): add for navigation purpose
    @Binding var path: NavigationPath
    
    @State private var isClicked = false
    //    let foodCategoriesJson: PreferenceDto = PreferenceDto.fromJson([:]) ??
    var foodCategoriesData: [FoodCategory] {
        let mirror = Mirror(reflecting: PreferenceDto())
        
        return mirror.children
            .compactMap {
                if $0.label != nil {
                    let label = $0.label!.replacingOccurrences(
                        of: "_", with: " ")
                    
                    return FoodCategory(
                        name: label
                    )
                }
                
                return nil
            }
    }
    @State var selectedName: Set<String> = []
    @State private var dragLocation: CGPoint = .zero
    @State private var buttonFrames: [String: CGRect] = [:]
    @State private var clickedButtons: Set<String> = []  // Track clicked buttons
    @State private var triggerHaptics = false
    
    func addCategory(_ name: String) {
        if selectedName.contains(name) {
            selectedName.remove(name)
        } else {
            selectedName.insert(name)
        }
    }
    
    @State private var isDragging = false
    var onSelectionChange: (Set<String>) -> Void
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                dragLocation = value.location
                
                for (name, frame) in buttonFrames {
                    if frame.contains(dragLocation) {
                        if clickedButtons.contains(name) { return }
                        
                        clickedButtons.insert(name)
                        addCategory(name)
                    }
                }
                
                onSelectionChange(selectedName)
            }.onEnded { _ in
                clickedButtons.removeAll()
                triggerHaptics.toggle()
            }
        
    }
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("What are you craving for today?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                Spacer()
                WrappedLayout {
                    ForEach(foodCategoriesData, id: \.name) { item in
                        Button(action: {
                            withAnimation {
                                addCategory(item.name)
                                triggerHaptics.toggle()
                                onSelectionChange(selectedName)
                            }
                        }) {
                            Text(item.name)
                        }
                        .buttonStyle(
                            FoodCategoryButtonStyle(
                                isActive: selectedName.contains(item.name)
                            )
                        )
                        .sensoryFeedback(
                            .impact(weight: .light),
                            trigger: triggerHaptics
                        )
                        .background(
                            TrackFrameView(
                                name: item.name,
                                buttonFrames: $buttonFrames
                            )
                        )
                    }
                }
                .padding()
                .contentShape(Rectangle())
                
            }
            .padding()
        }
        .gesture(drag)
        .background(Color.gray.opacity(0.2))
    }
    
}

struct TrackFrameView: View {
    let name: String
    @Binding var buttonFrames: [String: CGRect]
    
    var body: some View {
        GeometryReader { geo in
            Color.clear
                .onAppear {
                    DispatchQueue.main.async {
                        buttonFrames[name] = CGRect(
                            x: geo.frame(in: .global).minX,
                            y: geo.frame(in: .global).minY - 80,
                            width: geo.frame(in: .global).width,
                            height: geo.frame(in: .global).height)
                    }
                }
        }
    }
}

#Preview {
    @Previewable @State var path: NavigationPath = NavigationPath()
    FilterView(path: $path) {
        preferences in
        for p in preferences {
            Logger.log(p)
        }
    }
}
