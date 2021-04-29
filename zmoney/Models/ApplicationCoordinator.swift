//
//  ApplicationCoordinator.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 24.04.21.
//

import UIKit

class ApplicationCoordinator {
    var window: UIWindow?
    private var storyboard = UIStoryboard(name: "Main", bundle: nil)
    private var loginView: LoginViewController?

    init() {
        Zservice.shared.delegate = self
    }

    func presentInitialView() {
        if let tabBarView: TabBarViewController = storyboard.instantiateVC() {
            window?.rootViewController = tabBarView
            window?.makeKeyAndVisible()
            presentLoginViewIfNeeded()
        }
    }

    private func presentLoginViewIfNeeded() {
        guard !Zservice.shared.isLoggedIn else { return }

        loginView = window?.rootViewController?.createAndPresentViewModally(
            viewOfType: LoginViewController.self,
            inPresentation: true
        )
    }
}

extension ApplicationCoordinator: ZserviceDelegate {
    func didLoggedIn() {
        loginView?.dismiss(animated: true, completion: nil)
    }

    func didLoggedOff() {
        presentLoginViewIfNeeded()
    }
}
