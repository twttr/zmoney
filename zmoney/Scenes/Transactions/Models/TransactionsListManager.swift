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
        if cacheService.loadEntities().isEmpty {
            zService.getDiff(since: 0) { (result) in
                switch result {
                case .success(let diffResponse):
                    self.cacheService.saveEntities(from: diffResponse)
                    let transactions = self.cacheService.loadEntities()
                    let transactionsModels = self.makeModels(transactionEntities: transactions)
                    completion(.success(transactionsModels))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            let transactions = self.cacheService.loadEntities()
            let transactionsModels = self.makeModels(transactionEntities: transactions)
            completion(.success(transactionsModels))
        }
    }

    func refreshTransactionsList(withCompletion completion: @escaping (Result<[TransactionCellModel], Error>) -> Void) {
        zService.getDiff(since: lastSyncTimeStamp) { (result) in
            switch result {
            case .success(let diffResponse):
                self.cacheService.saveEntities(from: diffResponse)
                let transactions = self.cacheService.loadEntities()
                let transactionsModels = self.makeModels(transactionEntities: transactions)
                completion(.success(transactionsModels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func makeModels(transactionEntities: [TransactionEntity]) -> [TransactionCellModel] {
        return transactionEntities.map { TransactionCellModel(transaction: $0) }
    }
}
