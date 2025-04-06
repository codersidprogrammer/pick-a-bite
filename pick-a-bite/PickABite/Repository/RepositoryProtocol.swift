//
//  TenantProtocol.swift
//  PickABite
//
//  Created by Dimaseditiya on 06/04/25.
//
import Foundation

protocol TenantRepositoryProtocol {
    func fetchAllTenants() throws -> [TenantModel]
    func addTenant(_ tenant: TenantModel) throws
    func updateTenant(_ tenant: TenantModel) throws
    func deleteTenant(_ tenant: TenantModel) throws
    func getTenant(byId id: UUID) throws -> TenantModel?
    func findTenant(byName name: String) throws -> TenantModel?
}
