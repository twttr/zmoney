//
//  NetworkErrorTests.swift
//  zmoneyTests
//
//  Created by Pavel Romanishkin on 07.05.21.
//

import XCTest
@testable import zmoney

class NetworkErrorTests: XCTestCase {

    var networkError: NetworkError!

    override func setUpWithError() throws {
        try super.setUpWithError()

        networkError = NetworkError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        networkError = nil
    }

    func testReturnBadRequestError() throws {
        let error = networkError.returnError(rawValue: 400)
        XCTAssertEqual(error.localizedDescription, HttpStatus.badRequest.errorDescription)
    }

    func testReturnUnauthorizedError() throws {
        let error = networkError.returnError(rawValue: 401)
        XCTAssertEqual(error.localizedDescription, HttpStatus.unauthorized.errorDescription)
    }

    func testReturnUndefinedError() throws {
        let error = networkError.returnError(rawValue: 999)
        XCTAssertEqual(error.localizedDescription, HttpStatus.undefined.errorDescription)
    }
}
