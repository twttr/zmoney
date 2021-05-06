//
//  DiffResponseModel.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 15.04.21.
//

import Foundation

// swiftlint:disable identifier_name
// MARK: - DiffResponseModel
struct DiffResponseModel: Codable {
    let serverTimestamp: Int
    let instrument: [Int: Instrument]
    let country: [Country]
    let company: [Company]
    let user: [User]
    let account: [Account]
    let tag: [Tag]
    let budget: [Budget]
    let merchant: [Merchant]
    let reminder: [Reminder]
    let reminderMarker: [ReminderMarker]
    let transaction: [Transaction]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        serverTimestamp = try container.decode(Int.self, forKey: .serverTimestamp)
        instrument = try container.decode([Instrument].self, forKey: .instrument).reduce(into: [Int: Instrument]()) {
            $0[$1.id] = $1
        }
        country = try container.decode([Country].self, forKey: .country)
        company = try container.decode([Company].self, forKey: .company)
        user = try container.decode([User].self, forKey: .user)
        account = try container.decode([Account].self, forKey: .account)
        tag = try container.decode([Tag].self, forKey: .tag)
        budget = try container.decode([Budget].self, forKey: .budget)
        merchant = try container.decode([Merchant].self, forKey: .merchant)
        reminder = try container.decode([Reminder].self, forKey: .reminder)
        reminderMarker = try container.decode([ReminderMarker].self, forKey: .reminderMarker)
        var transactions = try container.decode([Transaction].self, forKey: .transaction)

        for index in transactions.indices {
            transactions[index].incomeTransactionInstrument = instrument[transactions[index].incomeInstrument]
            transactions[index].outcomeTransactionInstrument = instrument[transactions[index].outcomeInstrument]
        }
        transaction = transactions
    }
}

// MARK: - Account
struct Account: Codable {
    let id: String
    let user, instrument: Int
    let type: String
    let role: Int?
    let accountPrivate, savings: Bool
    let title: String
    let inBalance: Bool
    let creditLimit: Int
    let startBalance, balance: Double
    let company: Int?
    let archive, enableCorrection: Bool
    let startDate, capitalization, percent: JSONNull?
    let changed: Int
    let syncID: [String]?
    let enableSMS: Bool
    let endDateOffset, endDateOffsetInterval, payoffStep, payoffInterval: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, user, instrument, type, role
        case accountPrivate = "private"
        case savings, title, inBalance, creditLimit,
             startBalance, balance, company, archive,
             enableCorrection, startDate, capitalization,
             percent, changed, syncID, enableSMS, endDateOffset,
             endDateOffsetInterval, payoffStep, payoffInterval
    }
}

// MARK: - Budget
struct Budget: Codable {
    let user, changed: Int
    let date, tag: String
    let income: Int
    let outcome: Double
    let incomeLock, outcomeLock: Bool
}

// MARK: - Company
struct Company: Codable {
    let id: Int
    let title: String
    let www: String?
    let country: Int?
    let fullTitle: String?
    let changed: Int
    let deleted: Bool
    let countryCode: String?
}

// MARK: - Country
struct Country: Codable {
    let id: Int
    let title: String
    let currency: Int
    let domain: String?
}

// MARK: - Instrument
struct Instrument: Codable {
    let id: Int
    let title, shortTitle, symbol: String
    let rate: Double
    let changed: Int
}

// MARK: - Merchant
struct Merchant: Codable {
    let id: String
    let user: Int
    let title: String
    let changed: Int
}

// MARK: - Reminder
struct Reminder: Codable {
    let id: String
    let user: Int
    let income, outcome: Double
    let changed, incomeInstrument, outcomeInstrument, step: Int
    let points: [Int]
    let tag: [String]
    let startDate: String
    let endDate: JSONNull?
    let notify: Bool
    let interval: String?
    let incomeAccount, outcomeAccount: String
    let comment: String?
    let payee, merchant: JSONNull?
}

// MARK: - ReminderMarker
struct ReminderMarker: Codable {
    let id: String
    let user: Int
    let date: String
    let income, outcome: Double
    let changed, incomeInstrument, outcomeInstrument: Int
    let state: State
    let reminder, incomeAccount, outcomeAccount: String
    let comment: String?
    let payee, merchant: JSONNull?
    let notify: Bool
    let tag: [String]
}

enum State: String, Codable {
    case deleted
    case planned
    case processed
}

// MARK: - Tag
struct Tag: Codable {
    let id: String
    let user, changed: Int
    let icon: String
    let budgetIncome, budgetOutcome: Bool
    let tagRequired: Bool?
    let color, picture: JSONNull?
    let title: String
    let showIncome, showOutcome: Bool
    let parent: String?

    enum CodingKeys: String, CodingKey {
        case id, user, changed, icon, budgetIncome, budgetOutcome
        case tagRequired = "required"
        case color, picture, title, showIncome, showOutcome, parent
    }
}

// MARK: - Transaction
struct Transaction: Codable {
    let id: String
    let user: Int
    let date: String
    let income, outcome: Double
    let changed, incomeInstrument, outcomeInstrument, created: Int
    let originalPayee: String?
    let deleted, viewed: Bool
    let hold: Bool?
    let qrCode: String?
    let incomeAccount, outcomeAccount: String
    let tag: [String]?
    let comment: String?
    let payee: String?
    let opIncome: Int?
    let opOutcome: Double?
    let opIncomeInstrument: JSONNull?
    let opOutcomeInstrument: Int?
    let latitude, longitude: Double?
    let merchant, incomeBankID, outcomeBankID, reminderMarker: String?
    var incomeTransactionInstrument, outcomeTransactionInstrument: Instrument?
}

// MARK: - User
struct User: Codable {
    let id, country: Int
    let login: String
    let changed, currency, paidTill: Int
    let parent: Int?
    let countryCode, email: String
    let monthStartDay: Int
    let subscription: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(
                JSONNull.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull")
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
