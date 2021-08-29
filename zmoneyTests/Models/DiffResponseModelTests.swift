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

// swiftlint:disable force_cast
class DiffResponseModelTests: XCTestCase {
    func testInstrument() throws {
        // Given
        let instrumentJson = TestConstants.DiffResponses.instrumentJson

        // When
        let instrument = Instrument(instrumentJson)!

        // Then
        XCTAssertEqual(instrument.id, 1)
        XCTAssertEqual(instrument.title, "Доллар США")
        XCTAssertEqual(instrument.shortTitle, "USD")
        XCTAssertEqual(instrument.symbol, "$")
        XCTAssertEqual(instrument.rate, 74.1373)
        XCTAssertEqual(instrument.changed, 1620607164)
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
        let account = Account(accountJson)!

        // Then
        XCTAssertEqual(account.id, "20fcb30a-867a-4cf6-a525-6f7190679231")
        XCTAssertEqual(account.user, 1399696)
        XCTAssertEqual(account.instrument, 2)
        XCTAssertEqual(account.type, "debt")
        XCTAssertEqual(account.role, nil)
        XCTAssertEqual(account.accountPrivate, false)
        XCTAssertEqual(account.savings, nil)
        XCTAssertEqual(account.title, "Долги")
        XCTAssertEqual(account.inBalance, false)
        XCTAssertEqual(account.creditLimit, 0)
        XCTAssertEqual(account.startBalance, 0)
        XCTAssertEqual(account.balance, 0)
        XCTAssertEqual(account.company, nil)
        XCTAssertEqual(account.archive, false)
        XCTAssertEqual(account.enableCorrection, false)
        XCTAssertEqual(account.startDate, nil)
        XCTAssertEqual(account.capitalization, nil)
        XCTAssertEqual(account.percent, nil)
        XCTAssertEqual(account.changed, 1618781099)
        XCTAssertEqual(account.syncID, nil)
        XCTAssertEqual(account.enableSMS, false)
        XCTAssertEqual(account.endDateOffset, nil)
        XCTAssertEqual(account.endDateOffsetInterval, nil)
        XCTAssertEqual(account.payoffStep, nil)
        XCTAssertEqual(account.payoffInterval, nil)
    }

    func testTag() throws {
        // When
        let jsonTag = TestConstants.DiffResponses.tagJson
        let tag = Tag(jsonTag)!

        // Then
        XCTAssertEqual(tag.id, "a6c63e62-687d-4528-89b3-479f73564ab9")
        XCTAssertEqual(tag.user, 1399696)
        XCTAssertEqual(tag.changed, 1618781099)
        XCTAssertEqual(tag.icon, "3002_cars")
        XCTAssertEqual(tag.budgetIncome, false)
        XCTAssertEqual(tag.budgetOutcome, true)
        XCTAssertEqual(tag.tagRequired, nil)
        XCTAssertEqual(tag.color, nil)
        XCTAssertEqual(tag.picture, nil)
        XCTAssertEqual(tag.title, "Машина")
        XCTAssertEqual(tag.showIncome, false)
        XCTAssertEqual(tag.showOutcome, true)
        XCTAssertEqual(tag.parent, nil)
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

    func testPartialJson() throws {
        // Given
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "diff_response_partial", ofType: "json") else { return }

        // When
        let diffResponseJson = try String(contentsOfFile: path)
        let diffResponseModel = DiffResponseModel(diffResponseJson)

        // Then
        XCTAssertNotNil(diffResponseModel)
    }

    func testFullJson() throws {
        // Given
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "diff_response_full", ofType: "json") else { return }

        // When
        let diffResponseJson = try String(contentsOfFile: path)
        let diffResponseModel = DiffResponseModel(diffResponseJson)

        // Then
        XCTAssertNotNil(diffResponseModel)
    }
}
