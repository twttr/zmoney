//
//  TransactionCellModel.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 29.04.21.
//

import UIKit
import MapKit

struct TransactionCellModel {
    let amount: String
    let date: Date
    let currency: String
    let isOutcome: Bool
    var categories: [String]
    let account: String
    let payee: String
    let categorySymbol: UIImage
    let categoryColor: UIColor
    let comment: String
    let coordinates: CLLocationCoordinate2D?
}

extension TransactionCellModel {
    init(transaction: Transaction) {
        isOutcome = transaction.income == 0
        date = transaction.date
        categories = transaction.categories?.map { $0.title } ?? []
        payee = transaction.payee ?? ""
        comment = transaction.comment ?? ""
        if let latitude = transaction.latitude, let longitude = transaction.longitude {
            coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            coordinates = nil
        }
        if let categoryIconString = transaction.categories?.first?.icon {
            categorySymbol = UIImage.zmoneyCategory(named: categoryIconString)
            categoryColor = UIColor.categoryColor(from: categoryIconString)
        } else {
            categorySymbol = UIImage(systemName: "questionmark")!
            categoryColor = .black
        }

        if isOutcome {
            amount = "- \(transaction.outcome)"
            currency = transaction.outcomeTransactionInstrument?.symbol ?? ""
            account = transaction.fromAccount?.title ?? ""
        } else {
            amount = "+ \(transaction.income)"
            currency = transaction.incomeTransactionInstrument?.symbol ?? ""
            account = transaction.toAccount?.title ?? ""
        }
    }
}

extension Date {
    func formatDateToString() -> String {
        if Calendar.current.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            return DateFormatter.dashSeparatorFormatter.string(from: self)
        }
    }
}
