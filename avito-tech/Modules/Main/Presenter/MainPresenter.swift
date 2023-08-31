//
//  MainPresenter.swift
//  avito-tech
//
//  Created by macbook Denis on 8/27/23.
//

import Foundation

protocol MainPresenterOutput: AnyObject {
    func onCellClicked(itemId: String)
}

final class MainPresenter {
    // Dependencies
    weak var view: MainViewInput?
    private let output: MainPresenterOutput?
    private let mainService: IMainService
    
    // Properties
    var dataSource: [Advertisement] = []
    
    // MARK: Init
    
    init(
        output: MainPresenterOutput?,
        mainService: IMainService
    ) {
        self.output = output
        self.mainService = mainService
    }
}

// MARK: - MainViewOutput

extension MainPresenter: MainViewOutput {
    func onCellClicked(itemId: String) {
        output?.onCellClicked(itemId: itemId)
    }
    
    func viewDidLoad() {
        if !ErrorService.shared.checkInternetConnection() {
            self.view?.showError()
        } else {
            mainService.loadAdvertisements { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let items):
                        self.dataSource = items.advertisements
                        self.view?.reloadData()
                    case .failure(_):
                        self.view?.showError()
                    }
                }
            }
        }
    }
}
