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
        transaction = Transaction(
            id: "0", user: 1, date: "", income: amount, outcome: 0.0, changed: 0, incomeInstrument: 0,
            outcomeInstrument: 0, created: 0, originalPayee: "", deleted: false, viewed: false,
            hold: false, qrCode: "", incomeAccount: "", outcomeAccount: "", tag: nil, comment: "",
            payee: "", opIncome: 0, opOutcome: 0, opIncomeInstrument: JSONNull(), opOutcomeInstrument: 0,
            latitude: 0.0, longitude: 0.0, merchant: "", incomeBankID: "", outcomeBankID: "", reminderMarker: "",
            incomeTransactionInstrument: nil, outcomeTransactionInstrument: nil
        )

        // When
        transactionCellModel = TransactionCellModel(transaction: transaction)

        // Then
        XCTAssertTrue(transactionCellModel.isOutcome)
    }

    func testTransactionIsNotOutcome() throws {
        // Given
        amount = 5.0
        transaction = Transaction(
            id: "0", user: 1, date: "", income: amount, outcome: 0.0, changed: 0, incomeInstrument: 0,
            outcomeInstrument: 0, created: 0, originalPayee: "", deleted: false, viewed: false,
            hold: false, qrCode: "", incomeAccount: "", outcomeAccount: "", tag: nil, comment: "",
            payee: "", opIncome: 0, opOutcome: 0, opIncomeInstrument: JSONNull(), opOutcomeInstrument: 0,
            latitude: 0.0, longitude: 0.0, merchant: "", incomeBankID: "", outcomeBankID: "", reminderMarker: "",
            incomeTransactionInstrument: nil, outcomeTransactionInstrument: nil
        )

        // When
        transactionCellModel = TransactionCellModel(transaction: transaction)

        // Then
        XCTAssertFalse(transactionCellModel.isOutcome)
    }

    func testTransactionDate() throws {
        // Given
        testDate = "testDate"
        transaction = Transaction(
            id: "0", user: 1, date: testDate, income: 5.0, outcome: 0.0, changed: 0, incomeInstrument: 0,
            outcomeInstrument: 0, created: 0, originalPayee: "", deleted: false, viewed: false,
            hold: false, qrCode: "", incomeAccount: "", outcomeAccount: "", tag: nil, comment: "",
            payee: "", opIncome: 0, opOutcome: 0, opIncomeInstrument: JSONNull(), opOutcomeInstrument: 0,
            latitude: 0.0, longitude: 0.0, merchant: "", incomeBankID: "", outcomeBankID: "", reminderMarker: "",
            incomeTransactionInstrument: nil, outcomeTransactionInstrument: nil
        )

        // When
        transactionCellModel = TransactionCellModel(transaction: transaction)

        // Then
        XCTAssertEqual(transactionCellModel.date, testDate)
    }

    func testOutcomeTransactionOutput() throws {
        // Given
        amount = 0.0
        transaction = Transaction(
            id: "0", user: 1, date: "", income: amount, outcome: amount, changed: 0, incomeInstrument: 0,
            outcomeInstrument: 0, created: 0, originalPayee: "", deleted: false, viewed: false,
            hold: false, qrCode: "", incomeAccount: "", outcomeAccount: "", tag: nil, comment: "",
            payee: "", opIncome: 0, opOutcome: 0, opIncomeInstrument: JSONNull(), opOutcomeInstrument: 0,
            latitude: 0.0, longitude: 0.0, merchant: "", incomeBankID: "", outcomeBankID: "", reminderMarker: "",
            incomeTransactionInstrument: nil, outcomeTransactionInstrument: instrument
        )

        // When
        transactionCellModel = TransactionCellModel(transaction: transaction)

        // Then
        XCTAssertEqual(transactionCellModel.amount, "Outcome \(transaction.outcome)")
        XCTAssertEqual(transactionCellModel.currency, instrument.shortTitle)
    }

    func testNotOutcomeTransactionOutput() throws {
        // Given
        amount = 5.0
        transaction = Transaction(
            id: "0", user: 1, date: "", income: amount, outcome: 0.0, changed: 0, incomeInstrument: 0,
            outcomeInstrument: 0, created: 0, originalPayee: "", deleted: false, viewed: false,
            hold: false, qrCode: "", incomeAccount: "", outcomeAccount: "", tag: nil, comment: "",
            payee: "", opIncome: 0, opOutcome: 0, opIncomeInstrument: JSONNull(), opOutcomeInstrument: 0,
            latitude: 0.0, longitude: 0.0, merchant: "", incomeBankID: "", outcomeBankID: "", reminderMarker: "",
            incomeTransactionInstrument: instrument, outcomeTransactionInstrument: nil
        )

        // When
        transactionCellModel = TransactionCellModel(transaction: transaction)

        // Then
        XCTAssertEqual(transactionCellModel.amount, "Income \(transaction.income)")
        XCTAssertEqual(transactionCellModel.currency, instrument.shortTitle)
    }
}
