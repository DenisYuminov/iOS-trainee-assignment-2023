//
//  ItemPresenter.swift
//  avito-tech
//
//  Created by macbook Denis on 8/28/23.
//

import Foundation

protocol ItemPresenterOutput: AnyObject {
    func onCellClicked(recipe: Int)
}

final class ItemPresenter {
    // Dependencies
    weak var view: ItemViewInput?
    private let output: ItemPresenterOutput?
    private let itemService: IItemService
    private let itemId: String
        
    // MARK: Init
    
    init(
        output: ItemPresenterOutput?,
        itemService: IItemService,
        itemId: String
    ) {
        self.output = output
        self.itemService = itemService
        self.itemId = itemId
    }
}

// MARK: - MainViewOutput
extension ItemPresenter: ItemViewOutput {
    
    func viewDidLoad() {
        if !ErrorService.shared.checkInternetConnection() {
            self.view?.showError()
        } else {
            itemService.loadItem(id: itemId) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let item):
                        self.view?.showItem(item: item)
                    case .failure(let error):
                        self.view?.showError()
                    }
                }
            }
        }
    }
}
