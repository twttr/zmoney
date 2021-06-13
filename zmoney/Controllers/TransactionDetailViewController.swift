//
//  TransactionDetailViewController.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 27.04.21.
//

import UIKit

enum DetailCell: Int {
    case transactionDetailInfoCell = 0
    case transactionCommentCell = 1
    case transactionMapCell = 2
}

class TransactionDetailViewController: UITableViewController {
    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak private var payeeLabel: UILabel!
    @IBOutlet weak private var accountLabel: UILabel!
    @IBOutlet weak private var categoryImageView: UIImageView!
    @IBOutlet weak private var backgroundImageView: UIImageView!

    var transactionCellModel: TransactionCellModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let transactionCellModel = transactionCellModel else { return }

        categoryLabel.text = transactionCellModel.categories.joined(separator: ",")
        payeeLabel.text = transactionCellModel.payee
        accountLabel.text = transactionCellModel.account
        categoryImageView.image = UIImage.categoryImage(
            from: transactionCellModel.categorySymbol,
            backgroundColor: transactionCellModel.categoryColor,
            padding: 2
        )
        setImageGradient(imageView: backgroundImageView)
    }

    private func setImageGradient(imageView: UIImageView) {
        let gradient = CAGradientLayer()
        gradient.frame = imageView.bounds
        let startColor = UIColor.black.withAlphaComponent(0.2).cgColor
        let endColor = UIColor.black.withAlphaComponent(0.4).cgColor
        gradient.colors = [startColor, endColor]
        imageView.layer.insertSublayer(gradient, at: 0)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.Heights.cellHeaderHeight
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let transactionCellModel = transactionCellModel else { return UITableViewCell() }

        switch indexPath.section {
        case DetailCell.transactionDetailInfoCell.rawValue:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.Cells.transactionDetailInfoCellIdentifier,
                for: indexPath
            ) as? TransactionDetailInfoCell else { return UITableViewCell() }
            cell.configureCell(with: transactionCellModel)

            return cell
        case DetailCell.transactionCommentCell.rawValue:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.Cells.transactionCommentCellIdentifier,
                for: indexPath
            ) as? TransactionCommentCell else { return UITableViewCell() }
            cell.configureCell(with: transactionCellModel)

            return cell
        case DetailCell.transactionMapCell.rawValue:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.Cells.transactionMapCellIdentifier,
                for: indexPath
            ) as? TransactionMapCell else { return UITableViewCell() }
            cell.configureCell(with: transactionCellModel)

            return cell
        default:
            return UITableViewCell()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let transactionCellModel = transactionCellModel else { return 0 }

        switch indexPath.section {
        case DetailCell.transactionDetailInfoCell.rawValue:
            return Constants.Heights.transactionDetailInfoCellHeight
        case DetailCell.transactionCommentCell.rawValue:
            guard !transactionCellModel.comment.isEmpty else { return 0 }

            return Constants.Heights.transactionCommentCellHeight
        case DetailCell.transactionMapCell.rawValue:
            guard transactionCellModel.coordinates != nil else { return 0 }

            return Constants.Heights.transactionMapCellHeight
        default:
            return 0
        }
    }
}
