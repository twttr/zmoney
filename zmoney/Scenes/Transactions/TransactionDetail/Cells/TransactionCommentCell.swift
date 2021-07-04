//
//  TransactionCommentCell.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 07.06.21.
//

import Foundation

import UIKit

class TransactionCommentCell: UITableViewCell {
    @IBOutlet weak private var commentTextLabel: UILabel!

    func configureCell(with model: TransactionCellModel) {
        commentTextLabel.text = model.comment
    }
}
