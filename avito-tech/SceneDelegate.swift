//
//  SceneDelegate.swift
//  avito-tech
//
//  Created by macbook Denis on 8/27/23.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // Dependencies
    var window: UIWindow?
    
    // MARK: UISceneDelegate
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        let appCoordinator = AppCoordinator(
            appPresentationAssembly: AppPresentationAssembly(servicesAssembly: AppServicesAssembly()),
            navigationContonroller: UINavigationController()
        )
        appCoordinator.createRootViewController()
        window.rootViewController = appCoordinator.navigationContonroller
        window.makeKeyAndVisible()
    }
}
