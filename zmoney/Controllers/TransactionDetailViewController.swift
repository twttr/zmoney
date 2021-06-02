//
//  TransactionDetailViewController.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 27.04.21.
//

import UIKit

class TransactionDetailViewController: UITableViewController {
    @IBOutlet weak private var amountLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var currencyLabel: UILabel!
    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak private var payeeLabel: UILabel!
    @IBOutlet weak private var accountLabel: UILabel!
    @IBOutlet weak private var categoryImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!

    var transactionCellModel: TransactionCellModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        amountLabel.text = transactionCellModel?.amount
        dateLabel.text = transactionCellModel?.date.formatDateToString()
        currencyLabel.text = transactionCellModel?.currency
        categoryLabel.text = transactionCellModel?.categories.joined(separator: ",")
        payeeLabel.text = transactionCellModel?.payee
        accountLabel.text = transactionCellModel?.account
        categoryImageView.image = transactionCellModel?.categorySymbol

        setImageGradient(imageView: backgroundImageView)
    }

    private func setImageGradient(imageView: UIImageView) {
        let gradient = CAGradientLayer()
        gradient.frame = imageView.bounds
        let startColor = UIColor.black.withAlphaComponent(0.8).cgColor
        let endColor = UIColor.black.withAlphaComponent(0.2).cgColor
        gradient.colors = [startColor, endColor]
        imageView.layer.insertSublayer(gradient, at: 0)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.Heights.cellHeaderHeight
    }
}
