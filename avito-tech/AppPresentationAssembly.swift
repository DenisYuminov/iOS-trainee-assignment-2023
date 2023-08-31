//
//  AppPresentationAssembly.swift
//  avito-tech
//
//  Created by macbook Denis on 8/27/23.
//

import Foundation

protocol IAppPresentationAssembly: AnyObject {
    // Coordinators
    var mainCoordinator: IMainCoordinator { get }
    var itemCoordinator: IItemCoordinator { get }
    // ModuleBuilders
    var mainAssembly: IMainAssembly { get }
    var itemAssembly: IItemAssembly { get }
}

final class AppPresentationAssembly: IAppPresentationAssembly {
    
    // Dependencies
    private let servicesAssembly: IAppServicesAssembly
    
    // MARK: Init
    
    init(servicesAssembly: IAppServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
    
    // MARK: Coordinators
    
    var mainCoordinator: IMainCoordinator {
        MainCoordinator(
            assembly: mainAssembly,
            itemCoordinator: itemCoordinator
        )
    }
    var itemCoordinator: IItemCoordinator {
        ItemCoordinator(assembly: itemAssembly)
    }
    // MARK: Assemblies

    var mainAssembly: IMainAssembly {
        MainAssembly(mainService: servicesAssembly.mainService)
    }
    var itemAssembly: IItemAssembly {
        ItemAssembly(itemService: servicesAssembly.itemService)
    }
}
