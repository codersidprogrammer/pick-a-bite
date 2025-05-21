//
//  RoulettePageView.swift
//  PickABite
//
//  Created by Dimaseditiya on 03/04/25.
//

import SwiftUI
import SwiftData


struct RoulettePageView: View {
    
    @EnvironmentObject var service: RoulettePageViewModel<UserHistoryRepository>
    @Environment(\.fromWidget) var fromWidget: Bool
    @StateObject var rouletteController: RouletteController = .init(segmentData: [])
    @State var whenSpinInfoTap: Bool = false
    @State private var animateShadow = false
    
    var whenNotHavingChance: Binding<Bool> {
        Binding(
            get: { !rouletteController.havingChance },
            set: { rouletteController.havingChance = !$0 }
        )
    }
    
    let preferences: [String]
    
    init() {
        self.preferences = [
            "🌶️ Spicy Dimas",
            "☕️ Coffee",
            "😌 Cozy"
        ]
    }
    init(preferences: [String]) {
        self.preferences = preferences
    }
    
    func normalizedKey(from name: String) -> String {
        let components =
        name
            .components(separatedBy: .whitespaces)
            .filter { !$0.contains(where: { $0.isEmoji }) }
        return components.joined(separator: "_")
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Your Preferences")
                    .font(.headline)
                    .foregroundStyle(Color.kombuGreen)
                    .padding(.horizontal, Sizing.md)
                    .padding(.top, Sizing.lg3)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Sizing.xs) {
                        ForEach(preferences, id: \.self) { value in
                            ChipOutlinedComponentView(value)
                        }
                    }
                    .padding(.horizontal, Sizing.md)
                }
            }
            .padding(.bottom, Sizing.xl3)
            
            RouletteComponentView(controller: rouletteController)
                .shadow(
                    color: Color.kombuGreen.opacity(animateShadow ? 0.6 : 0.2),
                    radius: animateShadow ? Sizing.lg : Sizing.md
                )
                .padding(.all, Sizing.md)
                .sheet(isPresented: $rouletteController.isSelected) {
                    HalfSheetView(
                        selectedSegment: $rouletteController.selectedSegment,
                        rouletteController: .constant(rouletteController)
                    )
                    .presentationDetents([.fraction(1)])
                    .presentationDragIndicator(.visible)
                    .onAppear(){
                        do {
                            try service.userHistoryRepo.add(
                                UserHistoryModel(
                                    tenantName: rouletteController.selectedSegment.description,
                                    
                                    // TODO: Change this into real selected preferences
                                    criteria: preferences.map{
                                        value in
                                        return value
                                    },
                                    spinSequence: rouletteController.countChances
                                )
                            )
                        } catch let error {
                            Logger.error(error.localizedDescription)
                        }
                    }
                }
                .alert("Oops!", isPresented: whenNotHavingChance) {
                    
                } message: {
                    Text("Unfortunatelly! you have no any chances now")
                }
                .onAppear(){
                    rouletteController.setSegment(
                        data: service.predictAsSegmentData(preffs: preferences.map{
                            val in
                            return normalizedKey(from: val)
                        })
                    )
                    do {
                        let a = try service.userHistoryRepo.fetchAll()
                        print(a)
                    } catch {
                        print(error)
                    }
                    
                    withAnimation(
                        Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true)
                    ) {
                        animateShadow.toggle()
                    }
                    
                    if fromWidget {
                        rouletteController.setSelectedState(fromWidget)
                    }
                }
            
            Spacer()
            PrimaryButtonComponentView(
                "Spin Now",
                action: {
                    rouletteController.spin()
                },
                iconName: ""
            )
            .padding(.horizontal, Sizing.md)
            
        }
        .background(
            ZStack {
                Color.cosmicLatte
                    .ignoresSafeArea()
//                Image("VividPattern")
//                    .resizable()
//                    .scaledToFill()
//                    .opacity(0.2)
                
            }
        )
    }
}

#Preview {
    @Previewable @State var isInitialized: Bool = false
    var service: RoulettePageViewModel<UserHistoryRepository> = {
        let dummyContext = try! ModelContainer(for: UserHistoryModel.self).mainContext
        let dummyRepo = UserHistoryRepository(context: dummyContext)
        return RoulettePageViewModel(repository: dummyRepo)
    }()
    
    RoulettePageView()
        .environmentObject(service)
        .environment(\.modelContext, RepositoryInitializer.instance.modelContainer.mainContext)
        .onAppear {
            if !isInitialized {
                service.userHistoryRepo = UserHistoryRepository(context: RepositoryInitializer.instance.modelContainer.mainContext)
                isInitialized = true
            }
        }
}
