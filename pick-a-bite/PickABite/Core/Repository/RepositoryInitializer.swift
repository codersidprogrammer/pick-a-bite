//
//  RepositoryInitializer.swift
//  PickABite
//
//  Created by Dimaseditiya on 06/04/25.
//
import SwiftData

@MainActor
final class RepositoryInitializer {
    static let instance = RepositoryInitializer()
    let modelContainer: ModelContainer
    private var repositories: [String:Any] = [:]
    
    private init() {
        do {
            let schemas = Schema([
                TenantModel.self,
                UserHistoryModel.self
            ])
            let modelConfiguration = ModelConfiguration(schema: schemas, isStoredInMemoryOnly: false)
            self.modelContainer = try ModelContainer(for: schemas, configurations: [modelConfiguration])
            
            /// REGISTERING REPOSITORY
            /// - Each new repository made, should be registered here
            /// - So that, we can list all available repositories
            register(TenantRepository(context: modelContainer.mainContext) as (any RepositoryProtocol))
            register(UserHistoryRepository(context: modelContainer.mainContext) as (any RepositoryProtocol))
            
        } catch let error {
            Logger.error(error.localizedDescription)
            fatalError("❌ Failed to create ModelContainer: \(error)")
        }
    }
    
    /// Register a repository with its protocol type
    func register<T>(_ repository: T) {
        let key = String(describing: T.self)
        repositories[key] = repository
    }
    
    /// Resolve repository by protocol type
    func resolve<T>() -> T? {
        let key = String(describing: T.self)
        return repositories[key] as? T
    }
}
