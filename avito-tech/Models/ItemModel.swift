//
//  ItemModel.swift
//  avito-tech
//
//  Created by macbook Denis on 8/31/23.
//

import Foundation

struct Item: Codable {
    let id, title, price, location: String
    let imageURL: String
    let createdDate, description, email, phoneNumber: String
    let address: String

    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case imageURL = "image_url"
        case createdDate = "created_date"
        case description, email
        case phoneNumber = "phone_number"
        case address
    }
}
