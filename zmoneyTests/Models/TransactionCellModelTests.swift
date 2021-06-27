//
//  TransactionCellModelTests.swift
//  zmoneyTests
//
//  Created by Pavel Romanishkin on 07.05.21.
//

import XCTest
@testable import zmoney

class TransactionCellModelTests: XCTestCase {
    var transactionCellModel: TransactionCellModel!
    var transaction: Transaction!
    var amount: Double!
    var testDate: String!
    var instrument: Instrument!

    override func setUpWithError() throws {
        try super.setUpWithError()

        instrument = Instrument.init(id: 1, title: "Euro", shortTitle: "EUR", symbol: "test", rate: 0.0, changed: 1)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        transaction = nil
        transactionCellModel = nil
        testDate = nil
        amount = nil
        instrument = nil
    }

    func testTransactionIsOutcome() throws {
        // Given
        amount = 0.0
        transaction = Transaction.init(
        """
            {
              "id": "2c5ded99-6e39-4ba0-88a1-0d2ef227f58b",
              "user": 688453,
              "date": "2019-05-07",
              "income": \(amount as Double),
              "outcome": 5000,
              "changed": 1559373979,
              "incomeInstrument": 2,
              "outcomeInstrument": 2,
              "created": 1557500136,
              "deleted": true,
              "viewed": true,
              "incomeAccount": "4530b5e7-9011-49cc-abfa-d5f3ec3354f0",
              "outcomeAccount": "32ab2492-7af6-4fdb-bae9-bf2e05cd3207"
            }
        """
        )

        // When
        transactionCellModel = TransactionCellModel(transaction: transaction)

        // Then
        XCTAssertTrue(transactionCellModel.isOutcome)
    }

    func testTransactionIsNotOutcome() throws {
        // Given
        amount = 5.0
        transaction = Transaction.init(
        """
            {
              "id": "2c5ded99-6e39-4ba0-88a1-0d2ef227f58b",
              "user": 688453,
              "date": "2019-05-07",
              "income": \(amount as Double),
              "outcome": 5000,
              "changed": 1559373979,
              "incomeInstrument": 2,
              "outcomeInstrument": 2,
              "created": 1557500136,
              "deleted": true,
              "viewed": true,
              "incomeAccount": "4530b5e7-9011-49cc-abfa-d5f3ec3354f0",
              "outcomeAccount": "32ab2492-7af6-4fdb-bae9-bf2e05cd3207"
            }
        """
        )

        // When
        transactionCellModel = TransactionCellModel(transaction: transaction)

        // Then
        XCTAssertFalse(transactionCellModel.isOutcome)
    }

    func testTransactionDate() throws {
        // Given
        testDate = "2019-05-07"
        transaction = Transaction.init(
        """
            {
              "id": "2c5ded99-6e39-4ba0-88a1-0d2ef227f58b",
              "user": 688453,
              "date": "\(testDate as String)",
              "income": 5000,
              "outcome": 5000,
              "changed": 1559373979,
              "incomeInstrument": 2,
              "outcomeInstrument": 2,
              "created": 1557500136,
              "deleted": true,
              "viewed": true,
              "incomeAccount": "4530b5e7-9011-49cc-abfa-d5f3ec3354f0",
              "outcomeAccount": "32ab2492-7af6-4fdb-bae9-bf2e05cd3207"
            }
        """
        )

        // When
        transactionCellModel = TransactionCellModel(transaction: transaction)

        // Then
        XCTAssertEqual(transactionCellModel.date, DateFormatter.dashSeparatorFormatter.date(from: testDate))
    }

    func testOutcomeTransactionOutput() throws {
        // Given
        amount = 0.0
        transaction = Transaction.init(
        """
            {
              "id": "2c5ded99-6e39-4ba0-88a1-0d2ef227f58b",
              "user": 688453,
              "date": "2019-05-07",
              "income": \(amount as Double),
              "outcome": \(amount as Double),
              "changed": 1559373979,
              "incomeInstrument": 2,
              "outcomeInstrument": 2,
              "created": 1557500136,
              "deleted": true,
              "viewed": true,
              "incomeAccount": "4530b5e7-9011-49cc-abfa-d5f3ec3354f0",
              "outcomeAccount": "32ab2492-7af6-4fdb-bae9-bf2e05cd3207"
            }
        """
        )

        // When
        transactionCellModel = TransactionCellModel(transaction: transaction)

        // Then
        XCTAssertEqual(transactionCellModel.amount, "- \(transaction.outcome)")
    }

    func testNotOutcomeTransactionOutput() throws {
        // Given
        amount = 5.0
        transaction = Transaction.init(
        """
            {
              "id": "2c5ded99-6e39-4ba0-88a1-0d2ef227f58b",
              "user": 688453,
              "date": "2019-05-07",
              "income": \(amount as Double),
              "outcome": \(amount as Double),
              "changed": 1559373979,
              "incomeInstrument": 2,
              "outcomeInstrument": 2,
              "created": 1557500136,
              "deleted": true,
              "viewed": true,
              "incomeAccount": "4530b5e7-9011-49cc-abfa-d5f3ec3354f0",
              "outcomeAccount": "32ab2492-7af6-4fdb-bae9-bf2e05cd3207"
            }
        """
        )

        // When
        transactionCellModel = TransactionCellModel(transaction: transaction)

        // Then
        XCTAssertEqual(transactionCellModel.amount, "+ \(transaction.income)")
    }
}
