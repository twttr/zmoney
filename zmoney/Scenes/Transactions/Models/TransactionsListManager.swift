//
//  TransactionsListManager.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 08.08.21.
//

import Foundation

class TransactionsListManager {

    private var cacheService = CacheService.shared
    private let zService = Zservice.shared
    private let lastSyncTimeStamp = UserDefaults.standard.integer(forKey: "lastSyncTimeStamp")

    func prepareTransactionsList(withCompletion completion: @escaping (Result<[TransactionCellModel], Error>) -> Void) {
        do {
            let transactions: [Transaction] = try self.cacheService.load()

            guard transactions.isEmpty else {
                let transactionsModels = self.makeModels(transactionEntities: transactions)
                completion(.success(transactionsModels))
                return
            }

            getDiff(sinceLast: false) { result in
                switch result {
                case .success(let transactionModels):
                    completion(.success(transactionModels))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }

    func refreshTransactionsList(withCompletion completion: @escaping (Result<[TransactionCellModel], Error>) -> Void) {
        getDiff(sinceLast: true) { result in
            switch result {
            case .success(let transactionModels):
                completion(.success(transactionModels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func getDiff(sinceLast: Bool, completion: @escaping (Result<[TransactionCellModel], Error>) -> Void) {
        let timestamp = sinceLast ? lastSyncTimeStamp : 0

        zService.getDiff(since: timestamp) { (result) in
            switch result {
            case .success(let diffResponse):
                do {
                    try self.cacheService.save(diffResponse.transaction)
                    let transactions: [Transaction] = try self.cacheService.load()
                    let transactionsModels = self.makeModels(transactionEntities: transactions)
                    completion(.success(transactionsModels))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func makeModels(transactionEntities: [Transaction]) -> [TransactionCellModel] {
        return transactionEntities.map { TransactionCellModel(transaction: $0) }
    }
}
