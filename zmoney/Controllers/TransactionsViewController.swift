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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Cells.transactionCellIdentifier,
            for: indexPath
        ) as? TransactionCell else { return UITableViewCell() }
        let transaction = transactionsList[indexPath.row]
        cell.configureCell(with: TransactionCellModel(transactionData: transaction, instrumentData: instruments))

        return cell
    }
}
