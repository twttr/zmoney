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

}

extension TransactionCellModel {
    init(transaction: Transaction) {
        isOutcome = transaction.income == 0
        date = transaction.date

        if isOutcome {
            amount = "Outcome \(transaction.outcome)"
            currency = transaction.outcomeTransactionInstrument?.shortTitle ?? ""
        } else {
            amount = "Income \(transaction.income)"
            currency = transaction.incomeTransactionInstrument?.shortTitle ?? ""
        }
    }
}
