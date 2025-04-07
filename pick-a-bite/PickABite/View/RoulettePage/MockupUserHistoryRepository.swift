//
//  MockupUserHistoryRepository.swift
//  PickABite
//
//  Created by Dimaseditiya on 06/04/25.
//

import Foundation

final class MockUserHistoryRepository: RepositoryProtocol {
    typealias EntityModel = UserHistoryModel

    private var mockData: [UserHistoryModel] = []

    init(initialData: [UserHistoryModel] = []) {
        self.mockData = initialData
    }

    func fetchAll() throws -> [UserHistoryModel] {
        return mockData
    }

    func get(byId id: UUID) throws -> UserHistoryModel? {
        return mockData.first(where: { $0.id == id })
    }

    func add(_ entity: UserHistoryModel) throws {
        mockData.append(entity)
    }

    func update(_ entity: UserHistoryModel) throws {
        guard let index = mockData.firstIndex(where: { $0.id == entity.id }) else { return }
        mockData[index] = entity
    }

    func delete(_ entity: UserHistoryModel) throws {
        mockData.removeAll(where: { $0.id == entity.id })
    }

    func find(byName name: String) throws -> UserHistoryModel? {
        return mockData.first(where: { $0.tenantName == name })
    }
}
