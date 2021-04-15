//
//  ViewController.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 07.02.21.
//

import UIKit

class LoginViewController: UIViewController {
    var isObserving = false

    deinit {
        if isObserving {
            UserDefaults.standard.removeObserver(self, forKeyPath: "accessToken")
        }
    }

    let zservice = Zservice()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaults.standard.addObserver(self, forKeyPath: "accessToken", options: .new, context: nil)
        isObserving = true
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        zservice.auth()
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if isObserving {
            UserDefaults.standard.removeObserver(self, forKeyPath: "accessToken")
        }
        navigateToTransactions()
    }

    func navigateToTransactions() {
        if let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") {
            destinationVC.modalPresentationStyle = .fullScreen
            present(destinationVC, animated: true, completion: nil)
        }
    }
}
