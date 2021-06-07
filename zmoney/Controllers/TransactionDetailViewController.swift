//
//  TransactionDetailViewController.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 27.04.21.
//

import UIKit
import MapKit

class TransactionDetailViewController: UITableViewController {
    @IBOutlet weak private var amountLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var currencyLabel: UILabel!
    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak private var payeeLabel: UILabel!
    @IBOutlet weak private var accountLabel: UILabel!
    @IBOutlet weak private var categoryImageView: UIImageView!
    @IBOutlet weak private var backgroundImageView: UIImageView!
    @IBOutlet weak private var commentTextLabel: UILabel!
    @IBOutlet weak private var transactionPlace: MKMapView!

    var transactionCellModel: TransactionCellModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let transactionCellModel = transactionCellModel else { return }

        amountLabel.text = transactionCellModel.amount
        dateLabel.text = transactionCellModel.date.formatDateToString()
        currencyLabel.text = transactionCellModel.currency
        categoryLabel.text = transactionCellModel.categories.joined(separator: ",")
        payeeLabel.text = transactionCellModel.payee
        accountLabel.text = transactionCellModel.account
        commentTextLabel.text = transactionCellModel.comment
        categoryImageView.image = UIImage.categoryImage(
            from: transactionCellModel.categorySymbol,
            backgroundColor: transactionCellModel.categoryColor,
            padding: 2
        )
        setImageGradient(imageView: backgroundImageView)
        if let coordinates = transactionCellModel.coordinates {
            let coordinateRegion = MKCoordinateRegion(
                center: coordinates,
                latitudinalMeters: 150,
                longitudinalMeters: 150
            )
            transactionPlace.setRegion(coordinateRegion, animated: false)
            let annotation = MKPointAnnotation()
            annotation.title = transactionCellModel.payee
            annotation.coordinate = coordinates
            transactionPlace.addAnnotation(annotation)
        } else {
            transactionPlace.isHidden = true
        }
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
}
