import SwiftUI
import SwiftData

struct HistoryPageView: View {
    @Environment(\.modelContext) private var modelContext
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
                    ModalView(isPresented: $isPresented, dataModel: $histories[0])
                        .presentationDetents([.fraction(0.6)])
                        .presentationDragIndicator(.visible)
                }
            }
        }
        .onAppear() {
            do {
                histories = try modelContext.fetch(FetchDescriptor<UserHistoryModel>())
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}




#Preview {
    HistoryPageView()
        .environment(\.modelContext, RepositoryInitializer.instance.modelContainer.mainContext)
}
