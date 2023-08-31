//
//  MainCoordinator.swift
//  avito-tech
//
//  Created by macbook Denis on 8/27/23.
//

import UIKit

protocol IMainCoordinator: AnyObject {
    func createFlow() -> UIViewController
}

final class MainCoordinator: IMainCoordinator, MainPresenterOutput {
    
    // Dependencies
    private let assembly: IMainAssembly
    private let itemCoordinator: IItemCoordinator
    
    
    // Properties
    private weak var transitionHandler: UIViewController?
    
    // MARK: Init
    
    init(
        assembly: IMainAssembly,
        itemCoordinator: IItemCoordinator
    ) {
        self.assembly = assembly
        self.itemCoordinator = itemCoordinator
    }
    
    // MARK: IMainCoordinator
    
    func createFlow() -> UIViewController {
        let viewController = assembly.build(output: self)
        transitionHandler = viewController
        return viewController
    }
    
    // MARK: MainPresenterOutput
    func onCellClicked(itemId: String) {
        let viewController = itemCoordinator.createFlow(itemId: itemId)
        transitionHandler?.navigationController?.pushViewController(viewController, animated: true)
    }
}
