//
//  ItemViewIO.swift
//  avito-tech
//
//  Created by macbook Denis on 8/28/23.
//

import Foundation

protocol ItemViewInput: AnyObject {
    func showItem(item: Item)
    func showError()
}

protocol ItemViewOutput: AnyObject {
    func viewDidLoad()
}
