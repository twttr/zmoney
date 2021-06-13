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

    func configureCell(with model: TransactionCellModel) {
        amountLabel.text = "\(model.amount) \(model.currency)"
        dateLabel.text = model.date.formatDateToString()
    }
}
