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
        self.stateController?.state = .loading
        zService.getDiff { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let diffResponse):
                self.transactionsModels = self.makeModels(diffResponse: diffResponse)

                DispatchQueue.main.async {
                    self.stateController?.state = .loaded
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.stateController?.state = .error(error.localizedDescription)
                }
            }
        }
    }

    private func makeModels(diffResponse: DiffResponseModel) -> [TransactionCellModel] {
        let transactions = diffResponse.transaction.sorted { $0.created > $1.created }
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
        return transactionsModels.count
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
}
