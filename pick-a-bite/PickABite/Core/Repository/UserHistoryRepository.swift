//
//  UserHistoryRepository.swift
//  PickABite
//
//  Created by Dimaseditiya on 06/04/25.
//


import Foundation
import SwiftData

final class UserHistoryRepository: RepositoryProtocol {
    typealias EntityModel = UserHistoryModel

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchAll() throws -> [UserHistoryModel] {
        let descriptor = FetchDescriptor<UserHistoryModel>()
        return try context.fetch(descriptor)
    }

    func get(byId id: UUID) throws -> UserHistoryModel? {
        let descriptor = FetchDescriptor<UserHistoryModel>(
            predicate: #Predicate { $0.id == id }
        )
        return try context.fetch(descriptor).first
    }

    func add(_ entity: UserHistoryModel) throws {
        context.insert(entity)
        try context.save()
    }

    func update(_ entity: UserHistoryModel) throws {
        try context.save()
    }

    func delete(_ entity: UserHistoryModel) throws {
        context.delete(entity)
        try context.save()
    }

    func find(byName name: String) throws -> UserHistoryModel? {
        let descriptor = FetchDescriptor<UserHistoryModel>(
            predicate: #Predicate { $0.tenantName == name }
        )
        return try context.fetch(descriptor).first
    }
}
