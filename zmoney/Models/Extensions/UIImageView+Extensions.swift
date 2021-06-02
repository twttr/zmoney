//
//  UIImageView+Extensions.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 02.06.21.
//

import UIKit

extension UIImageView {
    func prepareCategoryImage(from sourceImage: UIImage, backgroundColor: UIColor, padding: CGFloat) {
        self.image = sourceImage
        self.layer.cornerRadius = Constants.Buttons.cornerRadius
        self.backgroundColor = backgroundColor
        self.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        self.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
    }
}
