//
//  AuthResponseModel.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 13.04.21.
//

import Foundation

struct AuthResponse: Decodable {
    let accessToken, tokenType: String
    let expiresIn: Int
    let refreshToken: String

    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
    }
}
