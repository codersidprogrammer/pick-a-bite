//
//  HistoryPageViewModel.swift
//  PickABite
//
//  Created by Dimaseditiya on 09/04/25.
//

import Foundation
import Combine
import SwiftData

class HistoryViewService: ObservableObject {
    @Published var histories: [UserHistoryModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    var tenants: [TenantModel]

    var repository: UserHistoryRepository

    init(repository: UserHistoryRepository, tenants: [TenantModel] = []) {
        self.repository = repository
        self.tenants = tenants
        fetchHistories()
    }

    func fetchHistories() {
        isLoading = true
        errorMessage = nil

        do {
            let result = try repository.fetchAll()
            DispatchQueue.main.async {
                self.histories = result
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
