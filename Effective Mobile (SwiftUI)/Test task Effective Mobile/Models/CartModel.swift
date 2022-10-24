//
//  CartModel.swift
//  Test task Effective Mobile
//
//  Created by Илья Синицын on 10.10.2022.
//

import Foundation

// MARK: - CartModel
struct CartModel: Codable {
    let basket: [Basket]
    let delivery, id: String?
    let total: Int?
}

// MARK: - Basket
struct Basket: Codable, Hashable {
    let id: Int?
    let images: String?
    let price: Int?
    let title: String?
    var count: Int?
}
