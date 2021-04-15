//
//  ProfileViewController.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 15.04.21.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "accessToken")
        defaults.removeObject(forKey: "expiresIn")
        defaults.removeObject(forKey: "refreshToken")
        defaults.removeObject(forKey: "tokenType")
        if let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
            destinationVC.modalPresentationStyle = .fullScreen
            present(destinationVC, animated: true, completion: nil)
        }
    }
}
