//
//  TransactionDetailInfoCell.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 07.06.21.
//

import Foundation

import UIKit

class TransactionDetailInfoCell: UITableViewCell {
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var amountLabel: UILabel!
    @IBOutlet weak private var currencyLabel: UILabel!

    func configureCell(with model: TransactionCellModel) {
        amountLabel.text = model.amount
        currencyLabel.text = model.currency
        dateLabel.text = model.date.formatDateToString()
    }
}
