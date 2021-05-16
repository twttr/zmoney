//
//  zmoneyTests.swift
//  zmoneyTests
//
//  Created by Pavel Romanishkin on 07.02.21.
//

import XCTest
@testable import zmoney

class TokenServiceTests: XCTestCase {
    var tokenService: TokenService!
    var authResponse: AuthResponse!
    var accessToken: String!

    override func setUpWithError() throws {
        try super.setUpWithError()

        tokenService = TokenService()
        accessToken = "testAccessToken"
        authResponse = AuthResponse.init(
            accessToken: accessToken,
            tokenType: "testTokenType",
            expiresIn: 5,
            refreshToken: "refreshToken"
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        tokenService = nil
        accessToken = nil
        authResponse = nil
    }

    func testSaveToken() throws {
        // When
        tokenService.saveToken(from: authResponse)

        // Then
        XCTAssertEqual(tokenService.accessToken, accessToken)
    }

    func testRemoveToken() throws {
        // When
        tokenService.saveToken(from: authResponse)
        tokenService.removeToken()

        // Then
        XCTAssert(tokenService.accessToken.isEmpty)
    }

    func testReturnEmptyToken() throws {
        // Then
        XCTAssert(tokenService.accessToken.isEmpty)
    }
}
