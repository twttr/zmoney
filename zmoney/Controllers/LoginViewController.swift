//
//  ViewController.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 07.02.21.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak private var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = Constants.Buttons.cornerRadius
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.navigateToTransactions),
            name: .zMoneyConfigUpdated,
            object: nil
        )
    }

    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        Zservice.shared.auth()
    }

    @objc private func navigateToTransactions() {
        self.presentView(view: TabBarViewController())
    }
}
