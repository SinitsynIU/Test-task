//
//  ContentView.swift
//  Test task Effective Mobile
//
//  Created by Илья Синицын on 12.09.2022.
//

import SwiftUI

struct LoadingView: View {
    @EnvironmentObject var networkServiceManager: NetworkServiceManager
    @State private var isActive = false
    @State private var opacity = 0.0
    
    var body: some View {
        if isActive {
            HomeStoreView()
        } else {
            ZStack {
                Color("black")
                
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 132)
                    .opacity(opacity)
            }
            .ignoresSafeArea()
            .task {
                networkServiceManager.getData {
                    self.isActive = true
                }
            }
            .onAppear {
                withAnimation(.easeIn(duration: 1.2)) {
                    self.opacity = 1.0
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
