//
//  Category.swift
//  Test task Effective Mobile
//
//  Created by Илья Синицын on 13.09.2022.
//

import Foundation

class Category {
    var id: Int
    var image: String
    var text: String
    
    init(id: Int?, image: String?, text: String?) {
        self.id = id ?? 0
        self.image = image ?? ""
        self.text = text ?? ""
    }
}
