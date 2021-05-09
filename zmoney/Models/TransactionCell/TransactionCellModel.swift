//
//  TransactionCellModel.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 29.04.21.
//

import Foundation

struct TransactionCellModel {

    let amount: String
    let date: String
    let currency: String
    let isOutcome: Bool
    var categories: [String]
    let account: String

}

extension TransactionCellModel {
    init(transaction: Transaction) {
        isOutcome = transaction.income == 0
        date = transaction.date
        categories = []
        if let categoryEntitites = transaction.categories {
            for categoryEntity in categoryEntitites {
                categories.append(categoryEntity.title)
            }
        }

        if isOutcome {
            amount = "Outcome \(transaction.outcome)"
            currency = transaction.outcomeTransactionInstrument?.shortTitle ?? ""
            account = transaction.fromAccount?.title ?? ""
        } else {
            amount = "Income \(transaction.income)"
            currency = transaction.incomeTransactionInstrument?.shortTitle ?? ""
            account = transaction.fromAccount?.title ?? ""
        }
    }
}
