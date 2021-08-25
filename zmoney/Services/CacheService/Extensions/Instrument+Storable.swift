//
//  Instrument+Storable.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 24.08.21.
//

import CoreData

extension Instrument: Storable {

    @discardableResult
    func makeEntity(context: NSManagedObjectContext) -> InstrumentEntity {
        let instrumentEntity = InstrumentEntity(context: context)
        instrumentEntity.shortTitle = self.shortTitle
        instrumentEntity.symbol = self.symbol
        instrumentEntity.title = self.title
        instrumentEntity.rate = self.rate
        instrumentEntity.changed = Int32(self.changed)
        instrumentEntity.id = Int32(self.id)

        return instrumentEntity
    }

    init(entity: InstrumentEntity) {
        self.shortTitle = entity.shortTitle ?? ""
        self.symbol = entity.symbol ?? ""
        self.title = entity.title ?? ""
        self.rate = entity.rate
        self.changed = Int(entity.changed)
        self.id = Int(entity.id)
    }
}
