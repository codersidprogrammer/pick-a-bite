//
//  TenantRepository.swift
//  PickABite
//
//  Created by Dimaseditiya on 06/04/25.
//

import Foundation
import SwiftData

final class TenantRepository: TenantRepositoryProtocol {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchAllTenants() throws -> [TenantModel] {
        let descriptor = FetchDescriptor<TenantModel>()
        return try context.fetch(descriptor)
    }

    func getTenant(byId id: UUID) throws -> TenantModel? {
        let descriptor = FetchDescriptor<TenantModel>(
            predicate: #Predicate { $0.id == id }
        )
        return try context.fetch(descriptor).first
    }

    func addTenant(_ tenant: TenantModel) {
        do {
            context.insert(tenant)
            try context.save()
        } catch {
            Logger.error("❌ Failed to add tenant: \(error.localizedDescription)")
        }
    }

    func updateTenant(_ tenant: TenantModel) {
        do {
            try context.save()
        } catch {
            Logger.error("❌ Failed to update tenant: \(error.localizedDescription)")
        }
    }

    func deleteTenant(_ tenant: TenantModel) {
        do {
            context.delete(tenant)
            try context.save()
        } catch {
            Logger.error("❌ Failed to delete tenant: \(error.localizedDescription)")
        }
    }

    func findTenant(byName name: String) throws -> TenantModel? {
        let descriptor = FetchDescriptor<TenantModel>(
            predicate: #Predicate { $0.name == name }
        )
        return try context.fetch(descriptor).first
    }
}
