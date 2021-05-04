//
//  TransactionCell.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 16.04.21.
//

import UIKit

class TransactionCell: UITableViewCell {
    @IBOutlet weak private var amountLabel: UILabel!
    @IBOutlet weak private var currencyLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!

    func configureCell(with model: TransactionCellModel) {
        amountLabel.text = model.amount
        currencyLabel.text = model.currency
        dateLabel.text = model.date
    }
}
