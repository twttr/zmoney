//
//  ApplicationCoordinator.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 24.04.21.
//

import UIKit

protocol ApplicationCoordinatorDelegate: AnyObject {
    func userLoggedIn()
}

class ApplicationCoordinator {
    var window: UIWindow?
    weak var delegate: ApplicationCoordinatorDelegate?
    private var storyboard = UIStoryboard(name: "Main", bundle: nil)
    private var loginView: LoginViewController?
    private var tabBarView: TabBarViewController?

    init() {
        Zservice.shared.delegate = self
    }

    func presentInitialView() {
        guard tabBarView == nil else { return }

        tabBarView = storyboard.instantiateVC()
        window?.rootViewController = tabBarView
        window?.makeKeyAndVisible()
        presentLoginViewIfNeeded()
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
        DispatchQueue.main.async {
            self.loginView?.dismiss(animated: true, completion: nil)
            self.delegate?.userLoggedIn()
        }
    }

    func didLoggedOff() {
        presentLoginViewIfNeeded()
    }
}
