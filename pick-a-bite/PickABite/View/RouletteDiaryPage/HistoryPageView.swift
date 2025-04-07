import SwiftUI

struct HistoryPageView: View {
    @State private var isPresented: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    ForEach(0..<6, id: \.self) { _ in
                        DailyCard(isPresented: $isPresented)
                    }
                }
                .padding(.horizontal, 30)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Action back
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.black)
                    }
                }

                ToolbarItem(placement: .principal) {
                    Text("Roulette Diary")
                        .font(.system(size: 18, weight: .bold))
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            ModalView(isPresented: $isPresented)
                .presentationDetents([.height(550)])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    HistoryPageView()
}
