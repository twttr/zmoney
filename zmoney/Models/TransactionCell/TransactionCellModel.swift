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
        categories = transaction.categories?.reduce(into: [String]()) {
            $0.append($1.title)
        } ?? []

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
