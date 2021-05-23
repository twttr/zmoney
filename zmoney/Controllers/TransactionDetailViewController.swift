//
//  TransactionDetailViewController.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 27.04.21.
//

import UIKit

class TransactionDetailViewController: UIViewController {
    @IBOutlet weak private var amountLabel: UILabel!
    @IBOutlet weak private var accountLabel: UILabel!
    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var payeeLabel: UILabel!
    @IBOutlet weak var purchaseImageView: UIImageView!
    @IBOutlet weak var purchaseView: UIView!
    @IBOutlet weak var currencyLabel: UILabel!

    var transactionCellModel: TransactionCellModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        purchaseView.layer.cornerRadius = Constants.Buttons.cornerRadius

        amountLabel.text = transactionCellModel?.amount
        accountLabel.text = transactionCellModel?.account
        categoryLabel.text = transactionCellModel?.categories.joined(separator: ", ")
        dateLabel.text = transactionCellModel?.date
        payeeLabel.text = transactionCellModel?.payee
        currencyLabel.text = transactionCellModel?.currency
    }
}
