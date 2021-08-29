//
//  Array+Extensions.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 15.08.21.
//

import CoreData

protocol Storable {

    associatedtype StoreEntity: NSManagedObject

    init(entity: StoreEntity)

    @discardableResult
    func makeEntity(context: NSManagedObjectContext) -> StoreEntity
}

extension Array where Element: Storable {

    @discardableResult
    func makeEntities(context: NSManagedObjectContext) -> [Element.StoreEntity] {
        self.map { $0.makeEntity(context: context) }
    }
}
