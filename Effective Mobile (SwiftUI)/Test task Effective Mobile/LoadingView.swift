//
//  ContentView.swift
//  Test task Effective Mobile
//
//  Created by Илья Синицын on 12.09.2022.
//

import SwiftUI

struct LoadingView: View {
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var networkServiceManager: NetworkServiceManager
    @State private var isActive = false
    @State private var opacity = 0.0
    @State var isActiveFilterView: Bool = false
    
    var body: some View {
        if isActive {
            ZStack {
                if isActiveFilterView {
                    VStack(spacing: 0) {
                        Spacer()
                    
                        FilterView(isActiveFilterView: $isActiveFilterView)
                    }
                    .zIndex(1)
                    .ignoresSafeArea()
                }
                
                NavigationView {
                    TabBarView(isActiveFilterView: $isActiveFilterView)
                }
            }
        } else {
            ZStack {
                Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor)
                
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 132)
                    .opacity(opacity)
            }
            .ignoresSafeArea()
            .task {
                networkServiceManager.getData {
                    networkServiceManager.getProductDetails {
                        networkServiceManager.getCart {
                            updatedData {
                                self.isActive = true
                            }
                        }
                    }
                }
            }
            .onAppear {
                withAnimation(.easeIn(duration: 1.2)) {
                    self.opacity = 1.0
                }
            }
        }
    }
    
    func updatedData(completion: @escaping () -> ()) {
        cartManager.products = networkServiceManager.cartModels.first?.basket ?? []
        cartManager.total = networkServiceManager.cartModels.first?.total ?? 0
        cartManager.delivery = networkServiceManager.cartModels.first?.delivery ?? ""
        
        cartManager.products[0].count = 1
        cartManager.products[1].count = 1
        completion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .environmentObject(CartManager())
            .environmentObject(NetworkServiceManager())
    }
}

struct TabBarView: View {
    @Binding var isActiveFilterView: Bool
    @State var isPresentedCartView: Bool = false
    @State var selectedIndex: Int = 0
    let width: CGFloat = UIScreen.main.bounds.width
    
    init(isActiveFilterView: Binding<Bool>) {
        _isActiveFilterView = isActiveFilterView
        
        UITabBar.appearance().isHidden = true
    }
    
var body: some View {
    ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedIndex) {
                ShopView(isActiveFilterView: $isActiveFilterView)
                    .ignoresSafeArea(.all, edges:.all)
                    .tag(0)
                
                LikeView()
                    .ignoresSafeArea(.all, edges:.all)
                    .tag(2)
                
                ProfileView()
                    .ignoresSafeArea(.all, edges:.all)
                    .tag(3)
            }
            
            VStack(spacing: 0) {
                Spacer()
                
                HStack(spacing: 0) {
                    TabBarItemExplorerView()
                        .padding(.leading, 68)
                        .onTapGesture {
                            selectedIndex = 0
                        }
                    
                    TabBarCartItemView()
                        .padding(.leading, 47)
                        .onTapGesture {
                            isPresentedCartView.toggle()
                        }
                        .fullScreenCover(isPresented: $isPresentedCartView, content: CartView.init)
                    
                    TabBarItemView(image: Image(systemName: "heart"), width: 19, height: 17)
                        .padding(.leading, 52)
                        .onTapGesture {
                            selectedIndex = 2
                        }
                    
                    TabBarItemView(image: Image("person"), width: 17.01, height: 17.57)
                        .padding(.leading, 52)
                        .onTapGesture {
                            selectedIndex = 3
                        }
                    
                    Spacer()
                }
                .frame(width: width, height: 72)
                .background(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
                .cornerRadius(30)
            }
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.all, edges:.all)
    }
}

struct TabBarItemExplorerView: View {
    var body: some View {
        HStack {
            Circle()
                .frame(width: 8, height: 8)
                .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
            
            Text("Explorer")
                .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                .font(.system(size: 15))
                .fontWeight(.bold)
        }
        .frame(width: 78, height: 19)
    }
}

struct TabBarItemView: View {
let image: Image
let width: CGFloat
let height: CGFloat

    var body: some View {
        image
            .resizable()
            .frame(width: width, height: height)
            .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
    }
}

struct TabBarCartItemView: View {
@EnvironmentObject var cartManager: CartManager

    var body: some View {
        ZStack(alignment: .trailing) {
            Image("cart")
                .resizable()
                .frame(width: 17.54, height: 18)
                .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
            
            if cartManager.products.count > 0 {
                Text("\(cartManager.products.count)")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
                    .background(.red)
                    .clipShape(Circle())
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 11, trailing: -8))
            }
        }
    }
}
