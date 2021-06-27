//
//  TransactionDetailViewController.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 27.04.21.
//

import UIKit

enum DetailCellType {
    case info(model: TransactionCellModel)
    case comment(model: TransactionCellModel)
    case map(model: TransactionCellModel)
}

extension DetailCellType {
    var cellType: UITableViewCell.Type {
        switch self {
        case .info:
            return TransactionDetailInfoCell.self
        case .comment:
            return TransactionCommentCell.self
        case .map:
            return TransactionMapCell.self
        }
    }

    func dequeueReusableCell(tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: self.cellType),
            for: indexPath
        )

        switch self {
        case let .info(model):
            guard let cell = cell as? TransactionDetailInfoCell else { return nil }
            cell.configureCell(with: model)
            return cell
        case let .comment(model):
            guard let cell = cell as? TransactionCommentCell else { return nil }
            cell.configureCell(with: model)
            return cell
        case let .map(model):
            guard let cell = cell as? TransactionMapCell else { return nil }
            cell.configureCell(with: model)
            return cell
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

        tableView.allowsSelection = false
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

        var arrayOfCells: [DetailCellType] = [.info(model: transactionCellModel)]

        if !transactionCellModel.comment.isEmpty {
            arrayOfCells.append(.comment(model: transactionCellModel))
        }

        if transactionCellModel.coordinates != nil {
            arrayOfCells.append(.map(model: transactionCellModel))
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
        guard let cell = cells[indexPath.row].dequeueReusableCell(tableView: tableView, for: indexPath) else {
            return UITableViewCell()
        }

        return cell
    }
}
