//
//  TestConstants.swift
//  zmoneyTests
//
//  Created by Pavel Romanishkin on 13.05.21.
//

import Foundation

enum TestConstants {
    enum DiffResponses {
        public static let instrumentJson = """
            {
              "id": 1,
              "title": "Доллар США",
              "shortTitle": "USD",
              "symbol": "$",
              "rate": 74.1373,
              "changed": 1620607164
            }
            """
        public static let countryJson = """
            {
              "id": 1,
              "title": "Россия",
              "currency": 2,
              "domain": "ru"
            }
            """
        public static let companyJson = """
            {
              "id": 3,
              "title": "Альфа-Банк",
              "www": "alfabank.ru",
              "country": 1,
              "fullTitle": null,
              "changed": 1371738863,
              "deleted": false,
              "countryCode": "RU"
            }
            """
        public static let userJson = """
            {
              "id": 1399696,
              "country": 1,
              "login": null,
              "changed": 1620593327,
              "currency": 2,
              "paidTill": 1619991038,
              "parent": null,
              "countryCode": "RU",
              "email": "test@test.com",
              "monthStartDay": 1,
              "subscription": null
            }
            """
        public static let accountJson = """
            {
              "id": "20fcb30a-867a-4cf6-a525-6f7190679231",
              "user": 1399696,
              "instrument": 2,
              "type": "debt",
              "role": null,
              "private": false,
              "savings": null,
              "title": "Долги",
              "inBalance": false,
              "creditLimit": 0,
              "startBalance": 0,
              "balance": 0,
              "company": null,
              "archive": false,
              "enableCorrection": false,
              "startDate": null,
              "capitalization": null,
              "percent": null,
              "changed": 1618781099,
              "syncID": null,
              "enableSMS": false,
              "endDateOffset": null,
              "endDateOffsetInterval": null,
              "payoffStep": null,
              "payoffInterval": null
            }
            """
        public static let tagJson = """
            {
              "id": "a6c63e62-687d-4528-89b3-479f73564ab9",
              "user": 1399696,
              "changed": 1618781099,
              "icon": "3002_cars",
              "budgetIncome": false,
              "budgetOutcome": true,
              "required": null,
              "color": null,
              "picture": null,
              "title": "Машина",
              "showIncome": false,
              "showOutcome": true,
              "parent": null
            }
            """
        public static let budgetJson = """
            {
              "user": 123,
              "changed": 321,
              "date": "2021-04-18",
              "tag": "Test",
              "income": 1,
              "outcome": 0,
              "incomeLock": false,
              "outcomeLock": true
            }
            """
        public static let merchantJson = """
            {
              "id": "123",
              "user": 321,
              "title": "test",
              "changed": 1234
            }
            """
        public static let reminderJson = """
            {
              "id": "123",
              "user": 321,
              "income": 2,
              "outcome": 3,
              "changed": 123456,
              "incomeInstrument": 1,
              "outcomeInstrument": 3,
              "step": 4,
              "points": [
                7
              ],
              "tag": [
                "Test"
              ],
              "startDate": "2021-04-18",
              "endDate": null,
              "notify": false,
              "interval": "21",
              "incomeAccount": "123-456",
              "outcomeAccount": "654-321",
              "comment": "test",
              "payee": null,
              "merchant": null
            }
            """
        public static let reminderMarkerJson = """
            {
              "id": "123",
              "user": 321,
              "date": "2021-04-18",
              "income": 2,
              "outcome": 3,
              "changed": 123456,
              "incomeInstrument": 1,
              "outcomeInstrument": 3,
              "state": "deleted",
              "reminder": "test",
              "incomeAccount": "123-456",
              "outcomeAccount": "654-321",
              "comment": "test",
              "payee": null,
              "merchant": null,
              "notify": true,
              "tag": [
                "Test"
              ]
            }
            """
    }
}
