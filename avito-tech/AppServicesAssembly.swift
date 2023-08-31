//
//  AppServicesAssembly.swift
//  avito-tech
//
//  Created by macbook Denis on 8/31/23.
//

import Foundation

protocol IAppServicesAssembly: AnyObject {
    var mainService: IMainService { get }
    var networkService: INetworkService { get }
    var itemService: IItemService { get }
}

final class AppServicesAssembly: IAppServicesAssembly {
    var networkService: INetworkService { NetworkService() }
    var mainService: IMainService {
        MainService(networkService: networkService)
    }
    var itemService: IItemService {
        ItemService(networkService: networkService)
    }
}
