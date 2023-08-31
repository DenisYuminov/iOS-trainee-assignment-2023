//
//  AppCoordinator.swift
//  avito-tech
//
//  Created by macbook Denis on 8/27/23.
//

import UIKit

final class AppCoordinator {
    // Dependencies
    private let mainCoordinator: IMainCoordinator
    
    // Properties
    var navigationContonroller: UINavigationController
    
    // MARK: Init
    
    init(
        appPresentationAssembly: IAppPresentationAssembly,
        navigationContonroller: UINavigationController
    ) {
        self.mainCoordinator = appPresentationAssembly.mainCoordinator
        self.navigationContonroller = navigationContonroller
    }
    
    // MARK: Internal
    
    func createRootViewController() {
        let viewController = mainCoordinator.createFlow()
        navigationContonroller.pushViewController(viewController, animated: true)
    }
}
