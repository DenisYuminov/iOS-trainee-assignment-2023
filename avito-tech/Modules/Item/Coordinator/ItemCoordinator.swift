//
//  ItemCoordinator.swift
//  avito-tech
//
//  Created by macbook Denis on 8/28/23.
//

import UIKit

protocol IItemCoordinator: AnyObject {
    func createFlow(itemId: String) -> UIViewController
}

final class ItemCoordinator: IItemCoordinator, ItemPresenterOutput {
    
    // Dependencies
    private let assembly: IItemAssembly
    
    
    // Properties
    private weak var transitionHandler: UIViewController?
    
    // MARK: Init
    
    init(
        assembly: IItemAssembly
    ) {
        self.assembly = assembly
    }
    
    // MARK: IItemCoordinator
    
    func createFlow(itemId: String) -> UIViewController {
        let viewController = assembly.build(itemId: itemId,output: self)
        transitionHandler = viewController
        return viewController
    }
    
    func onCellClicked(recipe: Int) {
        
    }
}
