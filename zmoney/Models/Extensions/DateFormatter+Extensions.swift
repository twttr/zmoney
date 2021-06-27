//
//  DateFormatter+Extensions.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 29.05.21.
//

import Foundation

extension DateFormatter {
    public static let slashSeparatorFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                return formatter
            }()
    public static let dashSeparatorFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                return formatter
            }()
}
