//
//  Test_task_Effective_MobileApp.swift
//  Test task Effective Mobile
//
//  Created by Илья Синицын on 12.09.2022.
//

import SwiftUI

@main
struct Test_task_Effective_MobileApp: App {
    @StateObject var networkServiceManager = NetworkServiceManager()
    @StateObject var cartManager = CartManager()
    var body: some Scene {
        WindowGroup {
            LoadingView()
                .environmentObject(networkServiceManager)
                .environmentObject(cartManager)
        }
    }
}
