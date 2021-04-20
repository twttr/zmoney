//
//  UIViewController+Extensions.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 20.04.21.
//

import UIKit

extension UIViewController {
    func presentView<T: UIViewController>(view: T) {
        if let destinationVC: T = self.storyboard?.instantiateVC() {
            destinationVC.modalPresentationStyle = .fullScreen
            present(destinationVC, animated: true, completion: nil)
        }
    }

    func presentView<T: UIViewController>(view: T, using storyboard: UIStoryboard) -> T? {
        if let destinationVC: T = storyboard.instantiateVC() {
            destinationVC.modalPresentationStyle = .fullScreen
            present(destinationVC, animated: true, completion: nil)
            return destinationVC
        }
        return nil
    }
}
