//
//  TokenService.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 19.04.21.
//

import Foundation
import KeychainAccess

// TODO: Refactor

struct TokenService {
    public var accessToken: String {
        do {
            return try keychain.get("accessToken") ?? ""
        } catch {
            return ""
        }
    }
    static let shared = TokenService()

    private let keychain = Keychain(service: "com.twttrio.zmoney")

    func saveToken(from responseData: AuthResponse) {
        keychain["accessToken"] = responseData.accessToken
        keychain["expiresIn"] = "\(responseData.expiresIn)"
        keychain["refreshToken"] = responseData.refreshToken
        keychain["tokenType"] = responseData.tokenType

        NotificationCenter.default.post(name: .zMoneyConfigUpdated, object: nil)
    }

    func removeToken() {
        do {
            try keychain.remove("accessToken")
            try keychain.remove("expiresIn")
            try keychain.remove("refreshToken")
            try keychain.remove("tokenType")

            NotificationCenter.default.post(name: .zMoneyConfigUpdated, object: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
}
