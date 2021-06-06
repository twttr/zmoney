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
    @IBOutlet weak private var payeeLabel: UILabel!
    @IBOutlet weak private var accountLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!

    func configureCell(with model: TransactionCellModel) {
        amountLabel.text = model.amount
        currencyLabel.text = model.currency
        payeeLabel.text = model.payee.isEmpty ? "Payee Missing" : model.payee
        accountLabel.text = model.account
        categoryImage.image = UIImage.categoryImage(
            from: model.categorySymbol,
            backgroundColor: .lightGray,
            padding: 2
        )
    }
}
