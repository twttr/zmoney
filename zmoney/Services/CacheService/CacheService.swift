//
//  CacheService.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 01.08.21.
//

import CoreData

struct CacheService {

    static var shared = CacheService()

    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ZenmoneyModel")

        let description = NSPersistentStoreDescription()
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    public func save<T: Storable>(_ storableItems: [T]) throws {
        storableItems.makeEntities(context: persistentContainer.viewContext)
        try persistentContainer.viewContext.save()
    }

    public func load<T: Storable>() throws -> [T] {
        guard let entities = try persistentContainer.viewContext.fetch(
                T.StoreEntity.fetchRequest()
        ) as? [T.StoreEntity] else {
            return []
        }
        return entities.map { T(entity: $0) }
    }
}
