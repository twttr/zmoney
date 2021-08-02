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

    // swiftlint:disable force_cast
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func saveEntities(from responseModel: DiffResponseModel) {
        let transactions = responseModel.transaction.sorted {
            return $0.date > $1.date
        }

        transactions.forEach { transaction in
            let isOutcome = transaction.income == 0
            let transactionEntity = TransactionEntity(context: context)
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
            try context.save()
        } catch {
            print(error)
        }
    }

    func loadEntities() -> [TransactionEntity] {
        let request = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        var out: [TransactionEntity] = []
        do {
            out = try context.fetch(request)
        } catch {
            print(error)
        }
        return out
    }
}
