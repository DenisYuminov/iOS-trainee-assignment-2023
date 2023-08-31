//
//  MainSerivce.swift
//  avito-tech
//
//  Created by macbook Denis on 8/31/23.
//

import Foundation

protocol IMainService: AnyObject {
    func loadAdvertisements(completion: @escaping (Result<MainPageResponse, Error>) -> Void)
}

class MainService: IMainService {
    let networkService: INetworkService
    
    init(networkService: INetworkService) {
        self.networkService = networkService
    }
    
    func loadAdvertisements(completion: @escaping (Result<MainPageResponse, Error>) -> Void) {
        let url = URL(string: "https://www.avito.st/s/interns-ios/main-page.json")!
        networkService.loadData(url: url, completion: completion)
    }
}
