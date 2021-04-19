//
//  TokenService.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 19.04.21.
//

import Foundation
import KeychainAccess

struct TokenService {
    var accessToken: String? {
        return try? keychain.get("accessToken")
    }
    static let shared = TokenService()

    let keychain = Keychain(service: "com.twttrio.zmoney")

    func saveToken(from responseData: AuthResponse) {
        keychain["accessToken"] = responseData.accessToken
        keychain["expiresIn"] = "\(responseData.expiresIn)"
        keychain["refreshToken"] = responseData.refreshToken
        keychain["tokenType"] = responseData.tokenType
    }

    func removeToken() {
        do {
            try keychain.remove("accessToken")
            try keychain.remove("expiresIn")
            try keychain.remove("refreshToken")
            try keychain.remove("tokenType")
        } catch {
            print(error.localizedDescription)
        }
    }

    func isTokenPresent() -> Bool {
        if let tokenString = try? keychain.get("accessToken"), !tokenString.isEmpty {
            return true
        } else {
            return false
        }
    }
}
