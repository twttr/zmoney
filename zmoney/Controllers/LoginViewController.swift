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

    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        Zservice.shared.auth()
    }
}
