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

    var amountValue: String?
    var currencyValue: String?
    var dateValue: String?

    override func awakeFromNib() {
        super.awakeFromNib()

        guard let amount = amountValue,
              let currency = currencyValue,
              let date = dateValue
        else { return }

        amountLabel.text = amount
        currencyLabel.text = currency
        dateLabel.text = date
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
