//
//  ViewController.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 07.02.21.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 5
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.navigateToTransactions),
            name: NSNotification.Name(rawValue: "LoggedIn"),
            object: nil
        )
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        Zservice.shared.auth()
    }

    @objc func navigateToTransactions() {
        if let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") {
            destinationVC.modalPresentationStyle = .fullScreen
            present(destinationVC, animated: true, completion: nil)
        }
    }
}