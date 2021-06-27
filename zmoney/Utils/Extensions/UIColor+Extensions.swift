//
//  UIColor+Extensions.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 06.06.21.
//

import UIKit

extension UIColor {
    static func categoryColor(from category: String) -> UIColor {
        let categoryHash = Int(category.hash / 10000000)

        srand48(categoryHash * 200)
        let red = CGFloat(drand48())

        srand48(categoryHash)
        let green = CGFloat(drand48())

        srand48(categoryHash / 200)
        let blue = CGFloat(drand48())

        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
