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
    let payee: String

}

extension TransactionCellModel {
    init(transaction: Transaction) {
        isOutcome = transaction.income == 0
        date = transaction.transactionDate?.formatDateToString() ?? "Unknown Date"
        categories = transaction.categories?.map { $0.title } ?? []
        payee = transaction.payee ?? ""

        if isOutcome {
            amount = "- \(transaction.outcome)"
            currency = transaction.outcomeTransactionInstrument?.symbol ?? ""
            account = transaction.fromAccount?.title ?? ""
        } else {
            amount = "+ \(transaction.income)"
            currency = transaction.incomeTransactionInstrument?.symbol ?? ""
            account = transaction.fromAccount?.title ?? ""
        }
    }
}

extension Date {
    func formatDateToString() -> String {
        if Calendar.current.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: self)
        }
    }
}
