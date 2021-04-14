//
//  ViewController.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 07.02.21.
//

import UIKit

class LoginViewController: UIViewController {

    deinit {
        UserDefaults.standard.removeObserver(self, forKeyPath: "accessToken")
    }

    let zservice = Zservice()

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let defaults = UserDefaults.standard

        if let accessToken = defaults.string(forKey: "accessToken"), !accessToken.isEmpty {
            navigateToTransactions()
        } else {
            defaults.addObserver(self, forKeyPath: "accessToken", options: .new, context: nil)
        }
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        zservice.auth()
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        UserDefaults.standard.removeObserver(self, forKeyPath: "accessToken")
        navigateToTransactions()
    }

    func navigateToTransactions() {
        performSegue(withIdentifier: "LoginToTransactions", sender: self)
    }
}
