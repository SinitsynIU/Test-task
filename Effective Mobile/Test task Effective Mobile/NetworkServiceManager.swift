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
                
    func getData(completion: @escaping () -> ()) {
        guard let url = URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let shopModel = try JSONDecoder().decode(ShopModel.self, from: data)
                DispatchQueue.main.async {
                    self?.shopModels.append(shopModel)
                    completion()
                }
            } catch {
                print("Failed to decode JSON, \(error.localizedDescription)")
            }
            
        }
        .resume()
    }
}
