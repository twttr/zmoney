//
//  NetworkError.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 14.04.21.
//

import Foundation

struct NetworkError: Error {
    func returnError(rawValue: Int) -> Error {
        switch rawValue {
        case 400:
             return HttpStatus.badRequest
        case 401:
            return HttpStatus.unauthorized
        default:
            return HttpStatus.undefined
        }
    }
}

enum HttpStatus: Error {
    case unauthorized
    case badRequest
    case undefined
}

extension HttpStatus: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badRequest:
            return """
            Server cannot or will not process the request\
            due to something that is perceived to be a client error
            """
        case .unauthorized:
            return """
            The request has not been applied because it lacks\
            valid authentication credentials for the target resource
            """
        case .undefined:
            return "The error code cannot be identified"
        }
    }
}
