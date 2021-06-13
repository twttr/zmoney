//
//  UICnstants.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 20.04.21.
//

import UIKit

enum Constants {
    enum Buttons {
        public static let cornerRadius: CGFloat = 5
    }
    enum Cells {
        public static let transactionCellIdentifier = "TransactionCell"
        public static let transactionDetailInfoCellIdentifier = "TransactionDetailInfoCell"
        public static let transactionCommentCellIdentifier = "TransactionCommentCell"
        public static let transactionMapCellIdentifier = "TransactionMapCell"
    }
    enum Segues {
        public static let transactionsToTransactionDetail = "ShowTransactionDetail"
    }
    enum Views {
        public static let loadingView = "LoadingView"
        public static let errorView = "ErrorView"
    }
    enum Heights {
        public static let cellHeaderHeight: CGFloat = 35
        public static let transactionDetailInfoCellHeight: CGFloat = 60
        public static let transactionCommentCellHeight: CGFloat = 60
        public static let ttransactionMapCellHeight: CGFloat = 250
        public static let transactionCellHeight: CGFloat = 75
    }
}
