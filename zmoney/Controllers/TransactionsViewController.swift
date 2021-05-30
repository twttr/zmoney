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
    private var transactionsModels = [TransactionCellModel]()
    private var refreshControl = UIRefreshControl()
    private var stateController: StateManager?
    private var sectionedTransactions = [[Date: [TransactionCellModel]]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        stateController = StateManager(rootView: self.view, loadedView: tableView)
        tableView.delegate = self
        tableView.dataSource = self

        refreshTransactionsList()

        tableView.refreshControl = refreshControl

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refreshTransactionsList), for: .valueChanged)

    }

    @objc private func refreshTransactionsList() {
        var state = self.stateController?.state

        if state == .noData {
            state = .loading
        }

        zService.getDiff { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let diffResponse):
                self.transactionsModels = self.makeModels(diffResponse: diffResponse)
                self.sectionedTransactions = Dictionary(grouping: self.transactionsModels, by: { $0.date }).map {
                    [$0.key: $0.value]
                }.sorted {
                    if let firstDate = $0.keys.first, let secondDate = $1.keys.first {
                        return firstDate > secondDate
                    } else {
                        return true
                    }
                }

                DispatchQueue.main.async {
                    state = .loaded
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    state = .error(error.localizedDescription)
                }
            }
        }
    }

    private func makeModels(diffResponse: DiffResponseModel) -> [TransactionCellModel] {
        let transactions = diffResponse.transaction.sorted {
            return $0.date > $1.date
        }
        return transactions.map { TransactionCellModel(transaction: $0) }
    }
}

extension TransactionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.Segues.transactionsToTransactionDetail, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? TransactionDetailViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }

        destinationVC.transactionCellModel = transactionsModels[indexPath.row]
    }
}

extension TransactionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionedTransactions[section].values.first?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Cells.transactionCellIdentifier,
            for: indexPath
        ) as? TransactionCell else { return UITableViewCell() }
        let transaction = transactionsModels[indexPath.row]
        cell.configureCell(with: transaction)

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionedTransactions[section].keys.first?.formatDateToString()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionedTransactions.count
    }
}
