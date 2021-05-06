//
//  UIViewController+Extensions.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 20.04.21.
//

import UIKit

extension UIViewController {
    func createAndPresentView<T: UIViewController>(viewOfType: T.Type) {
        if let destinationVC: T = self.storyboard?.instantiateVC() {
            destinationVC.modalPresentationStyle = .fullScreen
            present(destinationVC, animated: true, completion: nil)
        }
    }

    func createAndPresentViewModally<T: UIViewController>(viewOfType: T.Type, inPresentation: Bool) -> T? {
        if let destinationVC: T = self.storyboard?.instantiateVC() {
            destinationVC.isModalInPresentation = inPresentation ? true : false
            present(destinationVC, animated: true, completion: nil)
            return destinationVC
        }
        return nil
    }
}
