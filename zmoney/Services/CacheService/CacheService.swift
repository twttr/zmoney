//
//  CacheService.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 01.08.21.
//

import UIKit
import CoreData

struct CacheService {

    static var shared = CacheService()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TransactionEntity")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    mutating func saveEntities(from responseModel: DiffResponseModel) {
        let transactions = responseModel.transaction.sorted {
            return $0.date > $1.date
        }

        transactions.forEach { transaction in
            let isOutcome = transaction.income == 0
            let transactionEntity = TransactionEntity(context: persistentContainer.viewContext)
            transactionEntity.comment = transaction.comment
            transactionEntity.payee = transaction.payee
            transactionEntity.date = transaction.date
            transactionEntity.categories = transaction.categories?.map { $0.title } ?? []
            transactionEntity.categorySymbolString = transaction.categories?.first?.icon
            if let latitude = transaction.latitude, let longitude = transaction.longitude {
                transactionEntity.latitude = latitude
                transactionEntity.longitude = longitude
            }

            if isOutcome {
                transactionEntity.amount = "- \(transaction.outcome)"
                transactionEntity.currency = transaction.outcomeTransactionInstrument?.symbol
                transactionEntity.account = transaction.fromAccount?.title
            } else {
                transactionEntity.amount = "+ \(transaction.income)"
                transactionEntity.currency = transaction.incomeTransactionInstrument?.symbol
                transactionEntity.account = transaction.fromAccount?.title
            }
        }

        do {
            try persistentContainer.viewContext.save()
        } catch {
            print(error)
        }
    }

    mutating func loadEntities() -> [TransactionEntity] {
        let request = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        var out: [TransactionEntity] = []
        do {
            out = try persistentContainer.viewContext.fetch(request)
        } catch {
            print(error)
        }
        return out
    }

    private mutating func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
