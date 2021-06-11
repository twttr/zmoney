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

    var transactionCellModel: TransactionCellModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        amountLabel.text = transactionCellModel?.amount
        accountLabel.text = transactionCellModel?.account
        categoryLabel.text = transactionCellModel?.categories.joined(separator: ", ")
    }
}
