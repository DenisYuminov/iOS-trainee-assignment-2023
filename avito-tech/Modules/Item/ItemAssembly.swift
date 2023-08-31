//
//  ItemAssembly.swift
//  avito-tech
//
//  Created by macbook Denis on 8/28/23.
//

import UIKit

protocol IItemAssembly: AnyObject {
    func build(itemId: String, output: ItemPresenterOutput?) -> UIViewController
}

final class ItemAssembly: IItemAssembly {
    // Dependencies
    private let itemService: IItemService
    
    // MARK: Init
    
    init(itemService: IItemService) {
        self.itemService = itemService
    }
    
    // MARK: IITemModuleBuilder
    
    func build(itemId: String, output: ItemPresenterOutput?) -> UIViewController {
        let presenter = ItemPresenter(output: output, itemService: itemService, itemId: itemId)
        let view = ItemViewController(output: presenter)
        presenter.view = view
        return view
    }
}
