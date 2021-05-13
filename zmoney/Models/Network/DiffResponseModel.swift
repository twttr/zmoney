//
//  DiffResponseModel.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 15.04.21.
//

import Foundation

// swiftlint:disable identifier_name
// MARK: - DiffResponseModel
struct DiffResponseModel: Codable, Equatable {
    let serverTimestamp: Int
    let instrument: [Int: Instrument]
    let country: [Country]
    let company: [Company]
    let user: [User]
    let account: [Account]
    let tag: [String: Tag]
    let budget: [Budget]?
    let merchant: [Merchant]?
    let reminder: [Reminder]?
    let reminderMarker: [ReminderMarker]?
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
        tag = try container.decode([Tag].self, forKey: .tag).reduce(into: [String: Tag]()) {
            $0[$1.id] = $1
        }
        budget = try? container.decode([Budget].self, forKey: .budget)
        merchant = try? container.decode([Merchant].self, forKey: .merchant)
        reminder = try? container.decode([Reminder].self, forKey: .reminder)
        reminderMarker = try? container.decode([ReminderMarker].self, forKey: .reminderMarker)
        var transactions = try container.decode([Transaction].self, forKey: .transaction)

        for index in transactions.indices {
            transactions[index].incomeTransactionInstrument = instrument[transactions[index].incomeInstrument]
            transactions[index].outcomeTransactionInstrument = instrument[transactions[index].outcomeInstrument]

            if let categoriesStrings = transactions[index].tag {
                transactions[index].categories = []
                for categoryString in categoriesStrings {
                    if let unwrappedTag = tag[categoryString] {
                        transactions[index].categories?.append(unwrappedTag)
                    }
                }
            }

            if let account = account.filter({ $0.id == transactions[index].incomeAccount }).first {
                transactions[index].toAccount = account
            }

            if let account = account.filter({ $0.id == transactions[index].outcomeAccount }).first {
                transactions[index].fromAccount = account
            }
        }
        transaction = transactions
    }
}

// MARK: - Account
struct Account: Codable, Equatable {
    let id: String
    let user, instrument: Int
    let type: String
    let role: JSONNull?
    let accountPrivate: Bool
    let savings: JSONNull?
    let title: String
    let inBalance: Bool
    let creditLimit, startBalance, balance: Int
    let company: JSONNull?
    let archive, enableCorrection: Bool
    let startDate, capitalization, percent: JSONNull?
    let changed: Int
    let syncID: JSONNull?
    let enableSMS: Bool
    let endDateOffset, endDateOffsetInterval, payoffStep, payoffInterval: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, user, instrument, type, role
        case accountPrivate = "private"
        case savings, title, inBalance, creditLimit, startBalance,
             balance, company, archive, enableCorrection, startDate,
             capitalization, percent, changed, syncID, enableSMS,
             endDateOffset, endDateOffsetInterval, payoffStep, payoffInterval
    }
}

// MARK: - Budget
struct Budget: Codable, Equatable {
    let user, changed: Int
    let date, tag: String
    let income: Int
    let outcome: Double
    let incomeLock, outcomeLock: Bool
}

// MARK: - Company
struct Company: Codable, Equatable {
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
struct Country: Codable, Equatable {
    let id: Int
    let title: String
    let currency: Int
    let domain: String?
}

// MARK: - Instrument
struct Instrument: Codable, Equatable {
    let id: Int
    let title, shortTitle, symbol: String
    let rate: Double
    let changed: Int
}

// MARK: - Merchant
struct Merchant: Codable, Equatable {
    let id: String
    let user: Int
    let title: String
    let changed: Int
}

// MARK: - Reminder
struct Reminder: Codable, Equatable {
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
struct ReminderMarker: Codable, Equatable {
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
struct Tag: Codable, Equatable {
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
struct Transaction: Codable, Equatable {
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
    var categories: [Tag]?
    var fromAccount: Account?
    var toAccount: Account?
}

// MARK: - User
struct User: Codable, Equatable {
    let id, country: Int
    let login: JSONNull?
    let changed, currency, paidTill: Int
    let parent: JSONNull?
    let countryCode, email: String
    let monthStartDay: Int
    let subscription: JSONNull?
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
