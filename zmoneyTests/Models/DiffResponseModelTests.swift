//
//  DiffResponseModelTests.swift
//  zmoneyTests
//
//  Created by Pavel Romanishkin on 10.05.21.
//

import XCTest
@testable import zmoney

extension Instrument: JSONTestable {}
extension Country: JSONTestable {}
extension Company: JSONTestable {}
extension User: JSONTestable {}
extension Account: JSONTestable {}
extension Tag: JSONTestable {}
extension Transaction: JSONTestable {}
extension Budget: JSONTestable {}
extension Merchant: JSONTestable {}
extension Reminder: JSONTestable {}
extension ReminderMarker: JSONTestable {}
extension DiffResponseModel: JSONTestable {}

class DiffResponseModelTests: XCTestCase {
    func testInstrument() throws {
        // When
        let instrumentJson = TestConstants.DiffResponses.instrumentJson
        let instrument = Instrument(
            id: 1,
            title: "Доллар США",
            shortTitle: "USD",
            symbol: "$",
            rate: 74.1373,
            changed: 1620607164
        )

        // Then
        XCTAssertEqual(instrument, Instrument(instrumentJson))
    }

    func testCountry() throws {
        // When
        let countryJson = TestConstants.DiffResponses.countryJson
        let country = Country(
            id: 1,
            title: "Россия",
            currency: 2,
            domain: "ru"
        )

        // Then
        XCTAssertEqual(country, Country(countryJson))
    }

    func testCompany() throws {
        // When
        let companyJson = TestConstants.DiffResponses.companyJson
        let company = Company(
            id: 3, title: "Альфа-Банк", www: "alfabank.ru", country: 1,
            fullTitle: nil, changed: 1371738863, deleted: false, countryCode: "RU"
        )

        // Then
        XCTAssertEqual(company, Company(companyJson))
    }

    func testUser() throws {
        // When
        let userJson = TestConstants.DiffResponses.userJson
        let user = User(
            id: 1399696, country: 1, login: nil, changed: 1620593327, currency: 2,
            paidTill: 1619991038, parent: nil, countryCode: "RU",
            email: "test@test.com", monthStartDay: 1, subscription: nil
        )

        // Then
        XCTAssertEqual(user, User(userJson))
    }

    func testAccount() throws {
        // When
        let accountJson = TestConstants.DiffResponses.accountJson
        let account = Account(
            id: "20fcb30a-867a-4cf6-a525-6f7190679231", user: 1399696, instrument: 2, type: "debt",
            role: nil, accountPrivate: false, savings: nil, title: "Долги", inBalance: false,
            creditLimit: 0, startBalance: 0, balance: 0, company: nil, archive: false,
            enableCorrection: false, startDate: nil, capitalization: nil, percent: nil, changed: 1618781099,
            syncID: nil, enableSMS: false, endDateOffset: nil, endDateOffsetInterval: nil,
            payoffStep: nil, payoffInterval: nil
        )

        // Then
        XCTAssertEqual(account, Account(accountJson))
    }

    func testTag() throws {
        // When
        let jsonTag = TestConstants.DiffResponses.tagJson
        let tag = Tag(
            id: "a6c63e62-687d-4528-89b3-479f73564ab9", user: 1399696, changed: 1618781099,
            icon: "3002_cars", budgetIncome: false, budgetOutcome: true, tagRequired: nil,
            color: nil, picture: nil, title: "Машина", showIncome: false, showOutcome: true,
            parent: nil
        )

        // Then
        XCTAssertEqual(tag, Tag(jsonTag))
    }

    func testTransaction() throws {
        // When
        let jsonTransaction = TestConstants.DiffResponses.transactionJson
        let transaction = Transaction(
            id: "388fab00-9787-4c77-9e8a-61860bb2ab63", user: 1399696, date: "2021-04-18",
            income: 0.00, outcome: 1450.00, changed: 1618781099, incomeInstrument: 2,
            outcomeInstrument: 2, created: 1618781438, originalPayee: nil, deleted: false,
            viewed: true, hold: nil, qrCode: nil, incomeAccount: "94b1a868-4fdc-4412-924d-5fd8beb5cd05",
            outcomeAccount: "94b1a868-4fdc-4412-924d-5fd8beb5cd05", tag: ["c3b5d78b-ef6f-4f29-bd11-4b4a7475b80e"],
            comment: "Это демо-операция. Удалите её, когда посмотрите отчёты.", payee: "Пятерочка",
            opIncome: nil, opOutcome: nil, opIncomeInstrument: nil, opOutcomeInstrument: nil,
            latitude: nil, longitude: nil, merchant: nil, incomeBankID: nil, outcomeBankID: nil,
            reminderMarker: nil, incomeTransactionInstrument: nil, outcomeTransactionInstrument: nil)

        // Then
        XCTAssertEqual(transaction, Transaction(jsonTransaction))
    }

    func testBudget() throws {
        // When
        let budgetJson = TestConstants.DiffResponses.budgetJson
        let budget = Budget(
            user: 123, changed: 321, date: "2021-04-18",
            tag: "Test", income: 1, outcome: 0.00,
            incomeLock: false, outcomeLock: true
        )

        // Then
        XCTAssertEqual(budget, Budget(budgetJson))
    }

    func testMerchant() throws {
        // When
        let merchantJson = TestConstants.DiffResponses.merchantJson
        let merchant = Merchant(id: "123", user: 321, title: "test", changed: 1234)

        // Then
        XCTAssertEqual(merchant, Merchant(merchantJson))
    }

    func testReminder() throws {
        // When
        let reminderJson = TestConstants.DiffResponses.reminderJson
        let reminder = Reminder(
            id: "123", user: 321, income: 2.00, outcome: 3.00, changed: 123456,
            incomeInstrument: 1, outcomeInstrument: 3, step: 4, points: [7],
            tag: ["Test"], startDate: "2021-04-18", endDate: nil, notify: false,
            interval: "21", incomeAccount: "123-456", outcomeAccount: "654-321",
            comment: "test", payee: nil, merchant: nil)

        // Then
        XCTAssertEqual(reminder, Reminder(reminderJson))
    }

    func testReminderMarker() throws {
        // When
        let reminderMarkerJson = TestConstants.DiffResponses.reminderMarkerJson
        let reminderMarker = ReminderMarker(
            id: "123", user: 321, date: "2021-04-18", income: 2.00, outcome: 3.00,
            changed: 123456, incomeInstrument: 1, outcomeInstrument: 3, state: .deleted,
            reminder: "test", incomeAccount: "123-456", outcomeAccount: "654-321",
            comment: "test", payee: nil, merchant: nil, notify: true, tag: ["Test"])

        // Then
        XCTAssertEqual(reminderMarker, ReminderMarker(reminderMarkerJson))
    }

    func testFullJson() throws {
        // Given
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "diff_response", ofType: "json") else { return }

        // When
        let diffResponseJson = try String(contentsOfFile: path)
        let diffResponseModel = DiffResponseModel(diffResponseJson)

        // Then
        XCTAssertNotNil(diffResponseModel)
    }
}
