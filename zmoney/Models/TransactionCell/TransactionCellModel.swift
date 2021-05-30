//
//  TransactionCellModel.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 29.04.21.
//

import UIKit

struct TransactionCellModel {

    let amount: String
    let date: Date
    let currency: String
    let isOutcome: Bool
    var categories: [String]
    let account: String
    let payee: String
    let categorySymbol: UIImage

}

extension TransactionCellModel {
    init(transaction: Transaction) {
        isOutcome = transaction.income == 0
        date = transaction.date
        categories = transaction.categories?.map { $0.title } ?? []
        payee = transaction.payee ?? ""
        if let categoryIconString = transaction.categories?.first?.icon,
           let image = UIImage.zmoneyCategory(named: categoryIconString) {
            categorySymbol = image
        } else {
            categorySymbol = UIImage(systemName: "questionmark")!
        }

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
            return DateFormatter.slashSeparatorFormatter.string(from: self)
        }
    }
}
