//
//  ItemCellModel.swift
//  avito-tech
//
//  Created by macbook Denis on 8/28/23.
//

import Foundation

struct ItemCellModel: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageUrl: String
    let createdDate: String
}
