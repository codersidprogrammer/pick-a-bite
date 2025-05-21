//
//  TenantRepository.swift
//  PickABite
//
//  Created by Dimaseditiya on 06/04/25.
//

import Foundation
import SwiftData

final class TenantRepository: RepositoryProtocol {
    typealias EntityModel = TenantModel
    
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchAll() throws -> [TenantModel] {
        let descriptor = FetchDescriptor<TenantModel>()
        return try context.fetch(descriptor)
    }

    func get(byId id: UUID) throws -> TenantModel? {
        let descriptor = FetchDescriptor<TenantModel>(
            predicate: #Predicate { $0.id == id }
        )
        return try context.fetch(descriptor).first
    }

    func add(_ tenant: TenantModel) throws {
        context.insert(tenant)
        try context.save()
    }

    func update(_ tenant: TenantModel) throws {
        try context.save()
    }

    func delete(_ tenant: TenantModel) throws {
        context.delete(tenant)
        try context.save()
    }

    func find(byName name: String) throws -> TenantModel? {
        let descriptor = FetchDescriptor<TenantModel>(
            predicate: #Predicate { $0.name == name }
        )
        return try context.fetch(descriptor).first
    }
}

