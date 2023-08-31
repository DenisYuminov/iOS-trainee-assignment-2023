//
//  MainAssembly.swift
//  avito-tech
//
//  Created by macbook Denis on 8/27/23.
//

import UIKit

protocol IMainAssembly: AnyObject {
    func build(output: MainPresenterOutput?) -> UIViewController
}

final class MainAssembly: IMainAssembly {
    // Dependencies
    private let mainService: IMainService
    
    // MARK: Init
    
    init(mainService: IMainService) {
        self.mainService = mainService
    }
    
    // MARK: IMainModuleBuilder
    
    func build(output: MainPresenterOutput?) -> UIViewController {
        let presenter = MainPresenter(output: output, mainService: mainService)
        let view = MainViewController(output: presenter)
        presenter.view = view
        return view
    }
}
