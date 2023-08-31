//
//  NetworkService.swift
//  avito-tech
//
//  Created by macbook Denis on 8/27/23.
//

import Foundation


protocol INetworkService: AnyObject {
    func loadData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkService: INetworkService {
    func loadData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data!)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
