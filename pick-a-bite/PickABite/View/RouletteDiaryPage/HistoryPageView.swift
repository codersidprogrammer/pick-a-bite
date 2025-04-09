import SwiftUI
import SwiftData

struct HistoryPageView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isPresented: Bool = false
    @State var histories: [UserHistoryModel] = []
    @State var groupedHistories: [String: [UserHistoryModel]] = [:]
    
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
                    ForEach(Array(groupedHistories.sorted(by: { $0.key > $1.key }).enumerated()), id: \.offset) { index, value in
                        Section(header: Text(value.key)
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.top)) {
                            
                            ForEach(value.value, id: \.id) { history in
                                DailyCard(isPresented: $isPresented, dataModel: history)
                                    .listRowBackground(Color.clear)
                            }
                        }
                    }

                    .background(Color.clear)
                }
                .listStyle(PlainListStyle())
                .background(Color.clear)
                .sheet(isPresented: $isPresented) {
                    ModalView(isPresented: $isPresented, dataModel: $histories[0])
                        .padding(.horizontal, Sizing.md)
                        .padding(.vertical, Sizing.sm)
                        .presentationDetents([.fraction(0.6)])
                        .presentationDragIndicator(.visible)
                }
            }
        }
        .onAppear() {
            do {
                let descriptor = FetchDescriptor<UserHistoryModel>(
                    sortBy: [SortDescriptor<UserHistoryModel>(\.createdAt, order: .reverse)]
                )
                let formatter = DateFormatter()
                formatter.dateFormat = "EEEE, dd MMMM yyyy" // adjust if you want more readable format
                
                
                histories = try modelContext.fetch(descriptor)
                
                groupedHistories = Dictionary(grouping: histories) { item in
                    formatter.string(from: item.createdAt)
                }
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
