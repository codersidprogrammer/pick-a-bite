//
//  RepositoryProtocol.swift
//  PickABite
//
//  Created by Dimaseditiya on 06/04/25.
//
import Foundation

/// A generic protocol that defines the basic operations for a repository managing a specific entity model.
///
/// This protocol is intended to abstract the data access layer, allowing various implementations
/// (e.g., in-memory, Core Data, SwiftData, network-based) to manage CRUD operations on a specific `EntityModel`.
protocol RepositoryProtocol {
    
    /// The type of entity the repository manages.
    associatedtype EntityModel

    /// Fetches all entities from the repository.
    ///
    /// - Returns: An array of `EntityModel` instances.
    /// - Throws: An error if the fetch operation fails.
    func fetchAll() throws -> [EntityModel]

    /// Adds a new entity to the repository.
    ///
    /// - Parameter entity: The entity instance to add.
    /// - Throws: An error if the add operation fails.
    func add(_ entity: EntityModel) throws

    /// Updates an existing entity in the repository.
    ///
    /// - Parameter entity: The entity instance to update.
    /// - Throws: An error if the update operation fails.
    func update(_ entity: EntityModel) throws

    /// Deletes an entity from the repository.
    ///
    /// - Parameter entity: The entity instance to delete.
    /// - Throws: An error if the delete operation fails.
    func delete(_ entity: EntityModel) throws

    /// Retrieves a single entity by its UUID identifier.
    ///
    /// - Parameter id: The UUID of the entity to retrieve.
    /// - Returns: The matching `EntityModel` instance, or `nil` if not found.
    /// - Throws: An error if the fetch operation fails.
    func get(byId id: UUID) throws -> EntityModel?

    /// Searches for an entity by its name.
    ///
    /// - Parameter name: The name of the entity to search for.
    /// - Returns: The matching `EntityModel` instance, or `nil` if not found.
    /// - Throws: An error if the search operation fails.
    func find(byName name: String) throws -> EntityModel?
    
}

