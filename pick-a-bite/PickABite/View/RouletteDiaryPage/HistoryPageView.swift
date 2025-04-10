import SwiftUI
import SwiftData

struct HistoryPageView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isPresented: Bool = false
    @State private var selectedHistory: UserHistoryModel?
    @StateObject private var viewService = HistoryViewService(
        repository: UserHistoryRepository(
            context: ModelContext(try! ModelContainer(for: UserHistoryModel.self))
        )
    )
    var groupedHistories: [String: [UserHistoryModel]] {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM yyyy"
        return Dictionary(grouping: viewService.histories) { item in
            formatter.string(from: item.createdAt)
        }
    }
    
    private var historyListView: some View {
        List {
            ForEach(groupedHistories.sorted(by: { $0.key > $1.key }), id: \.key) { date, items in
                Section(header: Text(date)
                    .font(.headline)
                    .foregroundColor(.gray)) {
                        
                        ForEach(items, id: \.id) { history in
                            DailyCard(isPresented: $isPresented, dataModel: history)
                                .onTapGesture {
                                    selectedHistory = history
                                    isPresented = true
                                }
                                .listRowBackground(Color.clear)
                        }
                    }
            }
        }
        .listStyle(PlainListStyle())
        .background(Color.clear)
        .sheet(isPresented: $isPresented) {
            if let history = selectedHistory {
                ModalView(dataModel: history, onDismiss: {
                    isPresented = false})
                    .padding(.horizontal, Sizing.md)
                    .padding(.vertical, Sizing.sm)
                    .presentationDetents([.fraction(0.4)])
                    .presentationDragIndicator(.visible)
                    .background(Color.cosmicLatte)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.cosmicLatte.ignoresSafeArea()
            
            if viewService.isLoading {
                ProgressView()
            } else if viewService.histories.isEmpty {
                Text("No History")
                    .font(.title)
            } else {
                historyListView
            }
        }
        .onAppear {
            viewService.repository = UserHistoryRepository(context: modelContext)
            viewService.fetchHistories()
        }
    }
    
}

//struct HistoryPageView: View {
//    @Environment(\.modelContext) private var modelContext
//    @State private var isPresented: Bool = false
//    @State var histories: [UserHistoryModel] = []
//    @State var groupedHistories: [String: [UserHistoryModel]] = [:]
//
//    var body: some View {
//        ZStack {
//            Color.cosmicLatte.ignoresSafeArea()
//
//            if histories.isEmpty {
//                VStack {
//                    Text("No History")
//                        .font(.title)
//                }
//            } else {
//                List {
//                    let sortedGroupedHistories = groupedHistories.sorted { $0.key > $1.key }
//
//                    ForEach(Array(sortedGroupedHistories.enumerated()), id: \.offset) { index, element in
//                        let date = element.key
//                        let items = element.value
//
//                        Section(header: Text(date)
//                            .font(.headline)
//                            .foregroundColor(.gray)
//                            .padding(.top)) {
//
//                            ForEach(items, id: \.id) { history in
//                                DailyCard(isPresented: $isPresented, dataModel: history)
//                                    .listRowBackground(Color.clear)
//                            }
//                        }
//                    }
//
//                    .background(Color.clear)
//                }
//                .listStyle(PlainListStyle())
//                .background(Color.clear)
//                .sheet(isPresented: $isPresented) {
//                    ModalView(isPresented: $isPresented, dataModel: $histories[0])
//                        .padding(.horizontal, Sizing.md)
//                        .padding(.vertical, Sizing.sm)
//                        .presentationDetents([.fraction(0.6)])
//                        .presentationDragIndicator(.visible)
//                }
//            }
//        }
//        .onAppear() {
//            do {
//                let descriptor = FetchDescriptor<UserHistoryModel>(
//                    sortBy: [SortDescriptor<UserHistoryModel>(\.createdAt, order: .reverse)]
//                )
//                let formatter = DateFormatter()
//                formatter.dateFormat = "EEEE, dd MMMM yyyy" // adjust if you want more readable format
//
//
//                histories = try modelContext.fetch(descriptor)
//
//                groupedHistories = Dictionary(grouping: histories) { item in
//                    formatter.string(from: item.createdAt)
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
//    }
//}

//#Preview {
//    HistoryPageView()
//        .environment(\.modelContext, RepositoryInitializer.instance.modelContainer.mainContext)
//}
