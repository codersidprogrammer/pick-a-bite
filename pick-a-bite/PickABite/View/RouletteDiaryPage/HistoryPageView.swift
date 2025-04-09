import SwiftUI
import SwiftData

struct HistoryPageView: View {
    @EnvironmentObject var service: RoulettePageService<UserHistoryRepository>
    @State private var isPresented: Bool = false
    @State var histories: [UserHistoryModel] = []
    
    var body: some View {
        ZStack {
            Color.cosmicLatte.ignoresSafeArea()
            
            if histories.isEmpty {
                VStack {
                    Text("No History")
                        .font(.title)
                }
            } else {
                List {
                    
                    ForEach(Array(histories.enumerated()), id: \.offset) { index, value in
                        DailyCard(isPresented: $isPresented, dataModel: value)
                            .listRowBackground(Color.clear)
                    }
                    .background(Color.clear)
                }
                .listStyle(PlainListStyle())
                .background(Color.clear)
                .sheet(isPresented: $isPresented) {
                    ModalView(isPresented: $isPresented)
                        .presentationDetents([.fraction(0.6)])
                        .presentationDragIndicator(.visible)
                }
            }
        }
//        .onAppear{
//
//            DispatchQueue.main.async {
//                do {
//                    self.histories = try self.service.userHistoryRepo.fetchAll()
//                    print("Fetchedsss")
//                    print(self.histories)
//                } catch {
//                    print("Error fetching histories onAppear:", error)
//                }
//            }
//        }
        .onTapGesture {
//            TODO: Fix this for good one
            do {
                histories = try service.userHistoryRepo.fetchAll()
                print("Fetched")
                print(self.histories)
            } catch {
                print("Error fetching histories onAppear:", error)
            }
        }
    }
}




#Preview {
    @Previewable @State var isInitialized: Bool = false
    var service: RoulettePageService<UserHistoryRepository> = {
        // NOTE: Dummy init with a temporary context (won't be used)
        let dummyContext = try! ModelContainer(for: UserHistoryModel.self).mainContext
        let dummyRepo = UserHistoryRepository(context: dummyContext)
        return RoulettePageService(repository: dummyRepo)
    }()
    
    
    HistoryPageView()
        .environmentObject(service)
        .environment(\.modelContext, RepositoryInitializer.instance.modelContainer.mainContext)
        .onAppear {
            if !isInitialized {
                service.userHistoryRepo = UserHistoryRepository(context: RepositoryInitializer.instance.modelContainer.mainContext)
                isInitialized = true
            }
        }
}
