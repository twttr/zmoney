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
    private var instruments = [Instrument]()
    private var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        refreshTransactionsList()

        tableView.refreshControl = refreshControl

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refreshTransactionsList), for: .valueChanged)
    }

    @objc private func refreshTransactionsList() {
        zService.getDiff { (result) in
            switch result {
            case .success(let diffResponse):
                self.transactionsList = diffResponse.transaction.sorted { $0.created > $1.created }
                self.instruments = diffResponse.instrument
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            case .failure(let error):
                print(error)
                self.refreshControl.endRefreshing()
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
            if let currency = instruments.filter({ $0.id == transaction.incomeInstrument }).first?.shortTitle {
                cell.currencyValue = currency
            }
        } else {
            cell.amountValue = "Income \(transaction.income)"
            if let currency = instruments.filter({ $0.id == transaction.outcomeInstrument }).first?.shortTitle {
                cell.currencyValue = currency
            }
        }
        cell.dateValue = transaction.date

        return cell
    }
}
