//
//  CartManager.swift
//  Test task Effective Mobile
//
//  Created by Илья Синицын on 11.10.2022.
//

import Foundation
import SwiftUI

class CartManager: ObservableObject {
    @Published var products: [Basket] = []
    @Published var total: Int = 0
    @Published var delivery: String = "Free"
    
    func onIncrementCat(product: Basket) {
        if products == products.filter({$0.id != product.id}) {
            products.append(product)
            total += product.price ?? 0
        } else {
            total += product.price ?? 0
        }
    }
    
    func onDecrementCat(product: Basket) {
        if products == products.filter({$0.id == product.id}) {
            total -= product.price ?? 0
        }
    }
    
    func removeProductFromCat(product: Basket) {
        products = products.filter({$0.id != product.id})
        total -= (product.price ?? 0) * (product.count ?? 0)
    }
}
