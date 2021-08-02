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
    var categories: [String]
    let account: String
    let payee: String
    let categorySymbol: UIImage
    let categoryColor: UIColor
    let comment: String
    let coordinates: CLLocationCoordinate2D?

}

extension TransactionCellModel {
    init(transaction: TransactionEntity) {
        date = transaction.date ?? Date.init()
        categories = transaction.categories ?? []
        payee = transaction.payee ?? ""
        comment = transaction.comment ?? ""
        coordinates = CLLocationCoordinate2D(latitude: transaction.latitude, longitude: transaction.longitude)
        categorySymbol = UIImage.zmoneyCategory(named: transaction.categorySymbolString ?? "")
        categoryColor = UIColor.categoryColor(from: transaction.categorySymbolString ?? "")
        amount = transaction.amount ?? ""
        currency = transaction.currency ?? ""
        account = transaction.account ?? ""
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
