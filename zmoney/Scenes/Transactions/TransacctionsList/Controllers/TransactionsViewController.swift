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

    private var refreshControl = UIRefreshControl()
    private var stateController: StateManager?
    private var sectionedTransactions = [Section]()
    private var transactionsListManager = TransactionsListManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationItem.largeTitleDisplayMode = .automatic

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

        self.tableView.rowHeight = Constants.Heights.transactionCellHeight

        tableView.delegate = self
        tableView.dataSource = self

        stateController = StateManager(rootView: self.view, loadedView: tableView)

        tableView.refreshControl = refreshControl
        refreshControl.addTarget(
            self,
            action: #selector(refreshTransactionsList),
            for: .valueChanged
        )

        guard stateController?.state == .noData else { return }

        NotificationCenter.default.addObserver(forName: .zMoneyConfigUpdated, object: nil, queue: nil) { _ in
            DispatchQueue.main.async {
                self.refreshTransactionsList(initial: true)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard stateController?.state != .loaded else { return }

        self.refreshTransactionsList(initial: true)
    }

    @objc private func refreshTransactionsList(initial: Bool = false) {
        self.stateController?.state = .loading

        transactionsListManager.refreshTransactionsList(initial: initial) { [weak self] (result) in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.stateController?.state = .loaded
            }

            defer {
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                }
            }

            switch result {
            case .success(let model):
                self.sectionedTransactions = Dictionary(grouping: model, by: { $0.date }).map {
                    Section(date: $0.key, items: $0.value)
                }.sorted {
                    return $0.date > $1.date
                }
                DispatchQueue.main.async {
                   self.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    if initial {
                        self.stateController?.state = .error(error.localizedDescription)
                    }
                }
            }
        }
    }
}

extension TransactionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.Segues.transactionsToTransactionDetail, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
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
