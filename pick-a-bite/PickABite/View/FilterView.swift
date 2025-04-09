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
    @State private var viewModel = ViewModel()
    @State private var triggerHaptics = false
    
    var onSelectionChange: (Set<FoodCategory>) -> Void
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                VStack {
                    Text("What are you craving for today?")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                        .foregroundStyle(.kombuGreen)
                    Text("Pick your top 5 (or fewer) and let us surprise your taste 🎉")
                        .frame(width: 480)
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .foregroundColor(.kombuGreen.opacity(0.7))
                }
                
                WrappedLayout {
                    ForEach(viewModel.foodCategoriesData, id: \.key) { item in
                        Button(action: {
                            withAnimation {
                                viewModel.addOrRemoveSelected(item)
                                triggerHaptics.toggle()
                                onSelectionChange(viewModel.selected)
                            }
                        }) {
                            Text(item.name)
                        }
                        .buttonStyle(
                            FoodCategoryButtonStyle(
                                isActive: viewModel.selected.contains(item)
                            )
                        )
                        .disabled(
                            viewModel.selected.count == 5 && !viewModel.selected.contains(item)
                        )
                        .sensoryFeedback(
                            .impact(weight: .light),
                            trigger: triggerHaptics
                        )
                    }
                }
                .padding()
                .contentShape(Rectangle())
            }
            .padding()
        }
    }
    
}

extension Character {
    var isEmoji: Bool {
        return unicodeScalars
            .contains {
                $0.properties.isEmoji && (
                    $0.value > 0x238C || $0.properties.isEmojiPresentation
                )
            }
    }
}


#Preview {
    @Previewable @State var path: NavigationPath = NavigationPath()
    FilterView(path: $path, onSelectionChange: {
        preferences in
        for p in preferences {
//            Logger.log(p)
        }
    })
}
