//
//  Transaction+Extensions.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 13.08.21.
//

import CoreData

extension Transaction: Storable {

    @discardableResult
    func makeEntity(context: NSManagedObjectContext) -> TransactionEntity {
        let transactionEntity = TransactionEntity(context: context)
        transactionEntity.incomeAccount = self.incomeAccount
        transactionEntity.outcomeAccount = self.outcomeAccount
        transactionEntity.opIncome = self.opIncome ?? 0.0
        transactionEntity.opOutcome = self.opOutcome ?? 0.0
        transactionEntity.income = self.income
        transactionEntity.outcome = self.outcome
        transactionEntity.changed = Int32(self.changed)
        transactionEntity.incomeInstrument = Int32(self.incomeInstrument)
        transactionEntity.outcomeInstrument = Int32(self.outcomeInstrument)
        transactionEntity.comment = self.comment
        transactionEntity.date = self.date
        if let latitude = self.latitude, let longitude = self.longitude {
            transactionEntity.latitude = NSNumber(value: latitude)
            transactionEntity.longitude = NSNumber(value: longitude)
        }
        transactionEntity.payee = self.payee
        transactionEntity.id = self.id
        transactionEntity.user = Int32(self.user)
        transactionEntity.created = Int32(self.created)
        transactionEntity.originalPayee = self.originalPayee
        transactionEntity.viewed = self.viewed
        transactionEntity.hold = self.hold ?? false
        transactionEntity.qrCode = self.qrCode
        transactionEntity.incomeAccount = self.incomeAccount
        transactionEntity.outcomeAccount = self.outcomeAccount
        transactionEntity.tag = self.tag
        transactionEntity.opIncome = self.opIncome ?? 0.0
        transactionEntity.opOutcome = self.opOutcome ?? 0.0
        transactionEntity.opIncomeInstrument = Int32(self.opIncomeInstrument ?? 0)
        transactionEntity.opOutcomeInstrument = Int32(self.opOutcomeInstrument ?? 0)
        transactionEntity.merchant = self.merchant
        transactionEntity.incomeBankID = self.incomeBankID
        transactionEntity.outcomeBankID = self.outcomeBankID
        transactionEntity.reminderMaker = self.reminderMarker
        categories?.forEach({ category in
            transactionEntity.addToCategories(category.makeEntity(context: context))
        })
        transactionEntity.incomeTransactionInstrument = self.incomeTransactionInstrument?.makeEntity(context: context)
        transactionEntity.outcomeTransactionInstrument = self.outcomeTransactionInstrument?.makeEntity(context: context)

        return transactionEntity
    }

    init(entity: TransactionEntity) {
        self.comment = entity.comment
        if let date = entity.date {
            self.date = date
        } else {
            self.date = Date()
        }
        if let latitude = entity.latitude, let longitude = entity.longitude {
            self.latitude = Double(truncating: latitude)
            self.longitude = Double(truncating: longitude)
        } else {
            self.latitude = nil
            self.longitude = nil
        }
        self.payee = entity.payee
        self.id = entity.id ?? ""
        self.user = Int(entity.user)
        self.income = entity.income
        self.outcome = entity.outcome
        self.changed = Int(entity.changed)
        self.incomeInstrument = Int(entity.incomeInstrument)
        self.outcomeInstrument = Int(entity.outcomeInstrument)
        self.created = Int(entity.created)
        self.originalPayee = entity.originalPayee
        self.deleted = entity.isDeleted
        self.viewed = entity.viewed
        self.hold = entity.hold
        self.qrCode = entity.qrCode
        self.incomeAccount = entity.incomeAccount ?? ""
        self.outcomeAccount = entity.outcomeAccount ?? ""
        self.tag = entity.tag
        self.opIncome = entity.opIncome
        self.opOutcome = entity.opOutcome
        self.opIncomeInstrument = Int(entity.opIncomeInstrument)
        self.opOutcomeInstrument = Int(entity.opOutcomeInstrument)
        self.merchant = entity.merchant
        self.incomeBankID = entity.incomeBankID
        self.outcomeBankID = entity.outcomeBankID
        self.reminderMarker = entity.reminderMaker
        if let categories = entity.categories {
            for category in categories {
                if let categoryTag = category as? Tag {
                    self.categories?.append(categoryTag)
                }
            }
        }
        let tags = entity.categories?.compactMap({ $0 as? Tag }) ?? []
        categories?.append(contentsOf: tags)
        self.incomeTransactionInstrument = Instrument.init(
            entity: entity.incomeTransactionInstrument ?? InstrumentEntity.init()
        )
        self.outcomeTransactionInstrument = Instrument.init(
            entity: entity.outcomeTransactionInstrument ?? InstrumentEntity.init()
        )
    }
}
