//
//  TransactionMapCell.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 07.06.21.
//

import UIKit
import MapKit

class TransactionMapCell: UITableViewCell {
    @IBOutlet weak private var transactionMapView: MKMapView!

    func configureCell(with model: TransactionCellModel) {
        if let coordinates = model.coordinates {
            let coordinateRegion = MKCoordinateRegion(
                center: coordinates,
                latitudinalMeters: 150,
                longitudinalMeters: 150
            )
            transactionMapView.isZoomEnabled = false
            transactionMapView.isScrollEnabled = false
            transactionMapView.isUserInteractionEnabled = false
            transactionMapView.setRegion(coordinateRegion, animated: false)
            let annotation = MKPointAnnotation()
            annotation.title = model.payee
            annotation.coordinate = coordinates
            transactionMapView.addAnnotation(annotation)
        } else {
            transactionMapView.isHidden = true
        }
    }
}
