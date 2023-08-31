//
//  MainViewIO.swift
//  avito-tech
//
//  Created by macbook Denis on 8/27/23.
//

import Foundation

protocol MainViewInput: AnyObject {
    func reloadData()
    func showError()
}

protocol MainViewOutput: AnyObject {
    var dataSource: [Advertisement] { get set }
    func onCellClicked(itemId: String)
    func viewDidLoad()
}
