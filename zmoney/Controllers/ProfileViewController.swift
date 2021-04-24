//
//  ProfileViewController.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 15.04.21.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak private var nickLabel: UILabel!
    @IBOutlet weak private var emailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func logOutButtonTapped(_ sender: UIButton) {
        Zservice.shared.logout()
        self.presentView(view: LoginViewController())
    }
}
