//
//  TransactionsViewController.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 15.04.21.
//

import UIKit

class TransactionsViewController: UIViewController {
    @IBOutlet weak private var tableView: UITableView!

    private let zService = Zservice.shared
    private var transactionsList = [Transaction]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        zService.getDiff { (result) in
            switch result {
            case .success(let diffResponse):
                self.transactionsList = diffResponse.transaction.sorted { $0.created > $1.created }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension TransactionsViewController: UITableViewDelegate {
}

extension TransactionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Cells.transactionCellIdentifier,
            for: indexPath
        ) as! TransactionCell
        let transaction = transactionsList[indexPath.row]
        if transaction.income == 0 {
            cell.amountValue = "Outcome \(transaction.outcome)"
            cell.currencyValue = "\(transaction.opOutcome ?? 0.0)"
        } else {
            cell.amountValue = "Income \(transaction.income)"
            cell.currencyValue = "\(transaction.opIncome ?? 0)"
        }
        cell.dateValue = transaction.date

        return cell
    }
}
