//
//  ResponseData.swift
//  it FACTORY Test task
//
//  Created by Илья Синицын on 03.10.2022.
//

import Foundation

// MARK: - Data
struct JsonData: Codable, Hashable {
    let sections: [Section]
}

// MARK: - Section
struct Section: Codable, Hashable {
    let id, header: String
    let itemsTotal, itemsToShow: Int
    let items: [Item]
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
   
    static func == (lhs: Section, rhs: Section) -> Bool {
      lhs.id == rhs.id
    }
}

// MARK: - Item
struct Item: Codable, Hashable {
    let id: String
    let image: Image
    let title: String
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
   
    static func == (lhs: Item, rhs: Item) -> Bool {
      lhs.id == rhs.id
    }
}

// MARK: - Image
struct Image: Codable, Hashable {
    let the1X, the2X, the3X: String
    let aspectRatio: Int?
    let loopAnimation: Bool?

    enum CodingKeys: String, CodingKey {
        case the1X = "1x"
        case the2X = "2x"
        case the3X = "3x"
        case aspectRatio, loopAnimation
    }
}
