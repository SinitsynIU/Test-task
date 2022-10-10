//
//  NetworkServiceManager.swift
//  Test task Effective Mobile
//
//  Created by Илья Синицын on 21.08.2022.
//

import Foundation
import SwiftUI

class NetworkServiceManager: ObservableObject {
    @Published var shopModels: [ShopModel] = []
    @Published var detailsModels: [ProductDetailsModel] = []
                
    func getData(completion: @escaping () -> ()) {
        guard let url = URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let model = try JSONDecoder().decode(ShopModel.self, from: data)
                DispatchQueue.main.async {
                    self?.shopModels.append(model)
                    completion()
                }
            } catch {
                print("Failed to decode JSON, \(error.localizedDescription)")
            }
        }
        .resume()
    }
    
    func getProductDetails(completion: @escaping () -> ()) {
        guard let url = URL(string: "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let model = try JSONDecoder().decode(ProductDetailsModel.self, from: data)
                DispatchQueue.main.async {
                    self?.detailsModels.append(model)
                    completion()
                }
            } catch {
                print("Failed to decode JSON, \(error.localizedDescription)")
            }
        }
        .resume()
    }
}
