//
//  TransactionsViewController.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 15.04.21.
//

import UIKit

class TransactionsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let zService = Zservice.shared
    var transactionsList = [Transaction]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        zService.getDiff { (result) in
            switch result {
            case .success(let diffResponse):
                self.transactionsList = diffResponse.transaction
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
        let transaction = transactionsList[indexPath.row]
        if transaction.income == 0 {
            cell.amountLabel.text = "Outcome \(transaction.outcome)"
            cell.currencyLabel.text = "\(transaction.opOutcome ?? 0.0)"
        } else {
            cell.amountLabel.text = "Income \(transaction.income)"
            cell.currencyLabel.text = "\(transaction.opIncome ?? 0)"
        }
        cell.dateLabel.text = transaction.date

        return cell
    }
}
