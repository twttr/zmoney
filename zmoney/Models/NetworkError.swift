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

    enum HttpStatus: Error {
        case unauthorized
        case badRequest
        case undefined
    }
}
