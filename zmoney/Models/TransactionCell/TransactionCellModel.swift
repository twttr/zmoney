//
//  TransactionCellModel.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 29.04.21.
//

import Foundation

struct TransactionCellModel {
    let transactionData: Transaction
    let instrumentData: [Instrument]

    var amountValue: String {
        if isOutcome {
            return "Outcome \(transactionData.outcome)"
        } else {
            return "Income \(transactionData.income)"
        }
    }
    var dateValue: String {
        return transactionData.date
    }
    var currencyValue: String? {
        if isOutcome {
            return instrumentData.filter({ $0.id == transactionData.incomeInstrument }).first?.shortTitle
        } else {
            return instrumentData.filter({ $0.id == transactionData.outcomeInstrument }).first?.shortTitle
        }
    }

    private var isOutcome: Bool {
        return transactionData.income == 0
    }
}
