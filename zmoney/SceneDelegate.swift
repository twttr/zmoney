//
//  SceneDelegate.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 07.02.21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var applicationCoordinator = ApplicationCoordinator()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        applicationCoordinator.window = window
        applicationCoordinator.presentInitialView()
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        DispatchQueue.main.async {
            Zservice.shared.handleOauthRedirect(url: URLContexts.first?.url) {
                self.applicationCoordinator.presentInitialView()
            }
        }
    }
}
