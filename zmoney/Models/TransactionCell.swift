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

    var amountValue: String? = "" {
        didSet {
            amountLabel.text = amountValue
        }
    }
    var currencyValue: String? = "" {
        didSet {
            currencyLabel.text = currencyValue
        }
    }
    var dateValue: String? = "" {
        didSet {
            dateLabel.text = dateValue
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
