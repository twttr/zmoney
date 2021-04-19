//
//  TokenService.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 19.04.21.
//

import Foundation

struct TokenService {
    static let shared = TokenService()

    let defaults = UserDefaults.standard

    func saveToken(from responseData: AuthResponse) {
        defaults.set(responseData.accessToken, forKey: "accessToken")
        defaults.set(responseData.expiresIn, forKey: "expiresIn")
        defaults.set(responseData.refreshToken, forKey: "refreshToken")
        defaults.set(responseData.tokenType, forKey: "tokenType")
    }

    func removeToken() {
        defaults.removeObject(forKey: "accessToken")
        defaults.removeObject(forKey: "expiresIn")
        defaults.removeObject(forKey: "refreshToken")
        defaults.removeObject(forKey: "tokenType")
    }

    func isTokenPresent() -> Bool {
        if let tokenString = defaults.string(forKey: "accessToken"), !tokenString.isEmpty {
            return true
        } else {
            return false
        }
    }
}
