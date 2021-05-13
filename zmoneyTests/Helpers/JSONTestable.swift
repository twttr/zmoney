//
//  JSONTestable.swift
//  zmoneyTests
//
//  Created by Pavel Romanishkin on 13.05.21.
//

import Foundation

protocol JSONTestable {
    init?(_ json: String)
    func json() -> String?
}

extension JSONTestable where Self: Codable {
    init?(_ json: String) {
        guard
            let data = json.data(using: .utf8),
            let decoded = try? JSONDecoder().decode(Self.self, from: data)
            else { return nil }
        self = decoded
    }

    func json() -> String? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
