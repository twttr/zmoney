//
//  Tag+Storable.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 24.08.21.
//

import CoreData

extension Tag: Storable {
    @discardableResult
    func makeEntity(context: NSManagedObjectContext) -> TagEntity {
        let tagEntity = TagEntity(context: context)
        tagEntity.budgetIncome = self.budgetIncome
        tagEntity.budgetIncome = self.budgetIncome
        tagEntity.budgetOutcome = self.budgetOutcome
        tagEntity.showIncome = self.showIncome
        tagEntity.showOutcome = self.showOutcome
        tagEntity.tagRequired = self.tagRequired ?? false
        tagEntity.icon = self.icon
        tagEntity.id = self.id
        tagEntity.parent = self.parent
        tagEntity.picture = self.picture
        tagEntity.title = self.title
        tagEntity.changed = Int32(self.changed)
        tagEntity.color = Int32(self.color ?? 0)
        tagEntity.user = Int32(self.user ?? 0)

        return tagEntity
    }

    init(entity: TagEntity) {
        self.budgetIncome = entity.budgetIncome
        self.budgetOutcome = entity.budgetOutcome
        self.showIncome = entity.showIncome
        self.showOutcome = entity.showOutcome
        self.tagRequired = entity.tagRequired
        self.icon = entity.icon
        self.id = entity.id ?? ""
        self.parent = entity.parent
        self.picture = entity.picture
        self.title = entity.title ?? ""
        self.changed = Int(entity.changed)
        self.color = Int(entity.color)
        self.user = Int(entity.user)
    }
}
