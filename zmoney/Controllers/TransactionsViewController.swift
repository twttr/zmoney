//
//  TransactionsViewController.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 15.04.21.
//

import UIKit

class TransactionsViewController: UIViewController {
    @IBOutlet weak private var tableView: UITableView!

    private struct Section {
        let date: Date
        let items: [TransactionCellModel]
    }

    private let zService = Zservice.shared
    private var refreshControl = UIRefreshControl()
    private var stateController: StateManager?
    private var sectionedTransactions = [Section]()

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
                let transactionsModels = self.makeModels(diffResponse: diffResponse)
                self.sectionedTransactions = Dictionary(grouping: transactionsModels, by: { $0.date }).map {
                    Section(date: $0.key, items: $0.value)
                }.sorted {
                    return $0.date > $1.date
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

        destinationVC.transactionCellModel = sectionedTransactions[indexPath.section].items[indexPath.row]
    }
}

extension TransactionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionedTransactions[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Cells.transactionCellIdentifier,
            for: indexPath
        ) as? TransactionCell else { return UITableViewCell() }
        let transaction = sectionedTransactions[indexPath.section].items[indexPath.row]
        cell.configureCell(with: transaction)

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionedTransactions[section].date.formatDateToString()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionedTransactions.count
    }
}
