//
//  TransactionDetailViewController.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 27.04.21.
//

import UIKit

enum DetailCellType {
    case info
    case comment
    case map
}

extension DetailCellType: RawRepresentable {
    typealias RawValue = UITableViewCell

    init?(rawValue: UITableViewCell) {
        switch rawValue {
        case is TransactionDetailInfoCell:
            self = .info
        case is TransactionCommentCell:
            self = .comment
        case is TransactionMapCell:
            self = .map
        default:
            return nil
        }
    }

    var rawValue: UITableViewCell {
        switch self {
        case .info:
            return TransactionDetailInfoCell()
        case .comment:
            return TransactionCommentCell()
        case .map:
            return TransactionMapCell()
        }
    }
}

class TransactionDetailViewController: UITableViewController {
    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak private var payeeLabel: UILabel!
    @IBOutlet weak private var accountLabel: UILabel!
    @IBOutlet weak private var categoryImageView: UIImageView!
    @IBOutlet weak private var backgroundImageView: UIImageView!

    private var cells = [DetailCellType]()

    var transactionCellModel: TransactionCellModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let transactionCellModel = transactionCellModel else { return }

        categoryLabel.text = transactionCellModel.categories.joined(separator: ",")
        payeeLabel.text = transactionCellModel.payee
        accountLabel.text = transactionCellModel.account
        categoryImageView.image = UIImage.categoryImage(
            from: transactionCellModel.categorySymbol,
            targetSize: CGSize(
                width: Constants.Widths.categoryImageWidth,
                height: Constants.Heights.categoryImageHeight
            ),
            backgroundColor: transactionCellModel.categoryColor,
            padding: Constants.Paddings.categoryImagePadding
        )
        setImageGradient(imageView: backgroundImageView)

        cells = self.makeCells(from: transactionCellModel)
    }

    private func setImageGradient(imageView: UIImageView) {
        let gradient = CAGradientLayer()
        gradient.frame = imageView.bounds
        let startColor = UIColor.black.withAlphaComponent(0.2).cgColor
        let endColor = UIColor.black.withAlphaComponent(0.4).cgColor
        gradient.colors = [startColor, endColor]
        imageView.layer.insertSublayer(gradient, at: 0)
    }

    private func makeCells(from model: TransactionCellModel) -> [DetailCellType] {
        guard let transactionCellModel = transactionCellModel else { return [] }

        var arrayOfCells = [DetailCellType]()
        let infoCell = TransactionDetailInfoCell()
        if let infoCell = DetailCellType(rawValue: infoCell) {
            arrayOfCells.append(infoCell)
        }
        if !transactionCellModel.comment.isEmpty {
            let commentCell = TransactionCommentCell()
            if let commentCell = DetailCellType(rawValue: commentCell) {
                arrayOfCells.append(commentCell)
            }
        }
        if transactionCellModel.coordinates != nil {
            let mapCell = TransactionMapCell()
            if let mapCell = DetailCellType(rawValue: mapCell) {
                arrayOfCells.append(mapCell)
            }
        }
        return arrayOfCells
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.Heights.cellHeaderHeight
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let transactionCellModel = transactionCellModel else { return UITableViewCell() }

        switch cells[indexPath.row] {
        case .info:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.Cells.transactionDetailInfoCellIdentifier,
                for: indexPath
            ) as? TransactionDetailInfoCell else { return UITableViewCell() }
            cell.configureCell(with: transactionCellModel)

            return cell
        case .comment:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.Cells.transactionCommentCellIdentifier,
                for: indexPath
            ) as? TransactionCommentCell else { return UITableViewCell() }
            cell.configureCell(with: transactionCellModel)

            return cell
        case .map:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.Cells.transactionMapCellIdentifier,
                for: indexPath
            ) as? TransactionMapCell else { return UITableViewCell() }
            cell.configureCell(with: transactionCellModel)

            return cell
        }
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
