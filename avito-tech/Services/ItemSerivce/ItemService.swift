//
//  ItemService.swift
//  avito-tech
//
//  Created by macbook Denis on 8/31/23.
//

import Foundation

protocol IItemService: AnyObject {
    func loadItem(id: String, completion: @escaping (Result<Item, Error>) -> Void)
}

class ItemService: IItemService {
    let networkService: INetworkService
    
    init(networkService: INetworkService) {
        self.networkService = networkService
    }
    
    func loadItem(id: String, completion: @escaping (Result<Item, Error>) -> Void) {
        let url = URL(string: "https://www.avito.st/s/interns-ios/details/\(id).json")!
        networkService.loadData(url: url, completion: completion)
    }
}
