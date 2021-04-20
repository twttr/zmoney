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
        loginButton.layer.cornerRadius = 5
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.navigateToTransactions),
            name: NSNotification.Name(rawValue: ZMoneyNotifications.tokenUpdated),
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
