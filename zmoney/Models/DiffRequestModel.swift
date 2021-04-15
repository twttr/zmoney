//
//  DiffRequestModel.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 15.04.21.
//

import Foundation

struct DiffRequestModel: Codable {
    let currentClientTimestamp, serverTimestamp: Int
}
