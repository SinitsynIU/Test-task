//
//  DetailProductView.swift
//  Test task Effective Mobile
//
//  Created by Илья Синицын on 07.10.2022.
//

import SwiftUI

struct DetailView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            ProductNavigationBarView()
            
            ProdictImageScrollView()
            
            Spacer()
        
            DetailsProductView()
        }
        .padding(.top, 79)
        .ignoresSafeArea()
        .background(Color(UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1).cgColor))
        .navigationBarBackButtonHidden()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
            .environmentObject(NetworkServiceManager())
            .environmentObject(CartManager())
    }
}

struct DetailsProductNaviganionBarView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                        .frame(width: 37, height: 37)
                        .background(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
                        .cornerRadius(10)
                }
                .padding(.leading, 42)
                
                Spacer()
                
                Text("Product Details")
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                
                Spacer()
                
                Button {
                    print("Cart open")
                } label: {
                    Image("cart")
                        .resizable()
                        .frame(width: 13.64,height: 14)
                }
                .frame(width: 37, height: 37)
                .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                .background(Color(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1).cgColor))
                .cornerRadius(10)
                .padding(.trailing, 35)
            }
        }
    }
}

struct TabsView: View {
    let isActive: Bool
    let text: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            Text(text)
                .font(.system(size: 20))
                .fontWeight(isActive ? .bold : .regular)
                .foregroundColor(isActive ? Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor) : Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor))
        
            if isActive {
                Color(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1).cgColor)
                    .frame(width: 86,height: 2)
                    .clipShape(Capsule())
            }
        }
        .frame(width: 86)
        .padding(.trailing, 30)
    }
}

struct СharacteristicView: View {
    @EnvironmentObject var networkServiceManager: NetworkServiceManager
    let image: String
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            if image == "cpu" {
                VStack(alignment: .center, spacing: 0) {
                    Image(image)
                        .resizable()
                        .frame(width: 28, height: 28)
                    
                    Spacer()
                    
                    Text(networkServiceManager.detailModels.first?.cpu ?? "")
                        .font(.system(size: 11))
                        .fontWeight(.regular)
                        .foregroundColor(Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor))
                }
                .frame(width: 80, height: 50)
            } else if image == "camera" {
                VStack(alignment: .center, spacing: 0) {
                    Image(image)
                        .resizable()
                        .frame(width: 28, height: 22)
                    
                    Spacer()
                    
                    Text(networkServiceManager.detailModels.first?.camera ?? "")
                        .font(.system(size: 11))
                        .fontWeight(.regular)
                        .foregroundColor(Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor))
                }
                .frame(width: 80, height: 50)
            } else if image == "ssd" {
                VStack(alignment: .center, spacing: 0) {
                    Image(image)
                        .resizable()
                        .frame(width: 28, height: 21)
                    
                    Spacer()
                    
                    Text(networkServiceManager.detailModels.first?.ssd ?? "")
                        .font(.system(size: 11))
                        .fontWeight(.regular)
                        .foregroundColor(Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor))
                }
                .frame(width: 80, height: 50)
            } else if image == "sd" {
                VStack(alignment: .center, spacing: 0) {
                    Image(image)
                        .resizable()
                        .frame(width: 18.86, height: 22)
                    
                    Spacer()
                    
                    Text(networkServiceManager.detailModels.first?.sd ?? "")
                        .font(.system(size: 11))
                        .fontWeight(.regular)
                        .foregroundColor(Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor))
                }
                .frame(width: 80, height: 50)
            }
        }
        .frame(width: 80, height: 50)
        .padding(.trailing, 10)
    }
}

struct СharacteristicTextView: View {
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 11))
                .fontWeight(.regular)
                .foregroundColor(Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor))
        }
        .frame(width: 80)
    }
}

struct ColorView: View {
    let isActive: Bool
    let color: String
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.init(hex: color)
                .frame(width: 30, height: 30)
                .clipShape(Circle())
            
            if isActive {
                Image("chevron")
                    .resizable()
                    .frame(width: 16.96,height: 12.5)
            }
        }
    }
}

struct CapacityView: View {
    let isActive: Bool
    let text: String
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .frame(width: 71.43, height: 30.36)
                .foregroundColor(isActive ? Color(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1).cgColor) : .clear)
                .cornerRadius(10)
            
                Text(isActive ? "\(text) GB" : "\(text) gb")
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .foregroundColor(isActive ? Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor) : Color(UIColor(red: 0.554, green: 0.554, blue: 0.554, alpha: 1).cgColor))
        }
    }
}

struct ProdictImageScrollView: View {
    @EnvironmentObject var networkServiceManager: NetworkServiceManager

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 29) {
                ForEach(networkServiceManager.detailModels.first?.images ?? [], id: \.self) { index in
                    GeometryReader { geometry in
                        
                        let  scale = getScaleFactor(proxy: geometry)
        
                        ProductImageView(image: index)
                            .scaleEffect(CGSize(width: scale, height: scale))
                            .offset(x: -15)
                    }
                    .frame(width: 199, height: 279)
                }
                
            }
            .padding(32)
        }
    }
    
    func getScaleFactor(proxy: GeometryProxy) -> CGFloat {
        withAnimation(.easeIn) {
            var scale: CGFloat = 1
            let x = proxy.frame(in: .global).minX
            let diff = abs(x - 100)
            if diff > 100 {
                scale = 1 + (100 - diff) / 500
            }
            return scale
        }
    }
}

struct ProductImageView: View {
    let image: String
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor)
            AsyncImage(url: URL(string: image)) { URL in
                if let image = URL.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 220)
                        .clipped()
                }
            }
        }
        .frame(width: 220)
        .overlay(
            RoundedRectangle (cornerRadius: 10)
                .stroke(lineWidth: 0.5)
        )
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ProductNavigationBarView: View {
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack(spacing: 0) {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
            }
            .frame(width: 37, height: 37)
            .background(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
            .cornerRadius(10)
            .padding(.leading, 42)
            
            Spacer()
            
            Text("Product Details")
                .font(.system(size: 18))
                .fontWeight(.medium)
            
            Spacer()
            
            NavigationLink {
                CartView()
            } label: {
                ZStack {
                    Image("cart")
                        .resizable()
                        .frame(width: 13.64,height: 14)
                    
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
                .frame(width: 37, height: 37)
                .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                .background(Color(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1).cgColor))
                .cornerRadius(10)
            }
            .padding(.trailing, 35)
        }
    }
}

struct DetailsProductView: View {
    @EnvironmentObject var networkServiceManager: NetworkServiceManager
    @EnvironmentObject var cartManager: CartManager
    let width: CGFloat = UIScreen.main.bounds.width
    let tabs: [String] = ["Shop", "Details", "Features"]
    @State private var tabsSelectedIndex: String = "Shop"
    @State private var colorSelectedIndex: String = "#772D03"
    @State private var capacitySelectedIndex: String = "126"
    
    private let parametrs: [Category] = [
        Category(id: 0, image: "cpu", text: ""),
        Category(id: 1, image: "camera", text: ""),
        Category(id: 2, image: "ssd", text: ""),
        Category(id: 3, image: "sd", text: "")]
    private let product = Basket(id: 3, images: "https://avatars.mds.yandex.net/get-mpic/5235334/img_id5575010630545284324.png/orig", price: 1500, title: "Sumsung 5", count: 1)
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(networkServiceManager.detailModels.first?.title ?? "")
                    .font(.system(size: 24))
                    .fontWeight(.medium)
                    .foregroundColor(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
                    .padding(.leading, 38)
                
                Spacer()
                
                Button {
                    print("Like")
                } label: {
                    Image(systemName: (networkServiceManager.detailModels.first?.isFavorites ?? false) ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 14, height: 13)
                }
                .frame(width: 37, height: 37)
                .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                .background(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
                .cornerRadius(10)
                .padding(.trailing, 37)
                
            }
            .padding(.top, 28)
            
            HStack(spacing: 0) {
                ForEach(0 ..< 5) { index in
                    prodicrRaiting(index: index + 1, raiting: networkServiceManager.detailModels.first?.rating ?? 0.0)
                        .frame(width: 18, height: 18)
                        .foregroundColor(Color(UIColor(red: 1, green: 0.72, blue: 0, alpha: 1).cgColor))
                }
                
                Spacer()
            }
            .padding(.top, 7)
            .padding(.leading, 38)
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { index in
                    TabsView(isActive: tabsSelectedIndex == index, text: index)
                        .onTapGesture {
                            tabsSelectedIndex = index
                        }
                }
            }
            .padding(.top, 30)
            .padding(.horizontal, 27)
            
            VStack(spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(parametrs, id: \.id) { index in
                        СharacteristicView(image: index.image)
                    }
                }
                .padding(.leading, 30)
                .padding(.trailing, 40)
            }
            .padding(.top, 25)
            
            HStack(spacing: 0) {
                Text("Select color and capacity")
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
                    .padding(.leading, 25)
                
                Spacer()
            }
            .padding(.top, 29)
            
            HStack(spacing: 0) {
                ForEach(networkServiceManager.detailModels.first?.color ?? [], id: \.self) { index in
                    ColorView(isActive: colorSelectedIndex == index, color: index)
                        .padding(.trailing, 18.75)
                        .onTapGesture {
                            colorSelectedIndex = index
                        }
                }
                
                Spacer()
                
                ForEach(networkServiceManager.detailModels.first?.capacity ?? [], id: \.self) { index in
                    CapacityView(isActive: capacitySelectedIndex == index, text: index)
                        .padding(.trailing, 20.64)
                        .onTapGesture {
                            capacitySelectedIndex = index
                        }
                }
            }
            .padding(.leading, 34.57)
            .padding(.trailing, 60)
            .padding(.top, 14.71)
            
            Button {
                cartManager.onIncrementCat(product: product)
                
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    Text("Add to Cart")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                        .padding(.leading, 45)
                    
                    Spacer()
                    
                    Text("$\(networkServiceManager.detailModels.first?.price ?? 0)")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                        .padding(.trailing, 38)
                }
                .padding(.leading, 45)
            }
            .frame(width: 355, height: 54)
            .background(Color(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1).cgColor))
            .cornerRadius(10)
            .padding(.top, 27)
            
            Spacer()
        }
        .frame(width: width, height: 471)
        .background(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
        .cornerRadius(30)
        .shadow(color: Color(UIColor(red: 0.298, green: 0.372, blue: 0.562, alpha: 0.1).cgColor), radius: 20)
    }
    
    func prodicrRaiting(index: Int, raiting: Double) -> Image {
        if index > Int(raiting) {
            return Image(systemName: "star")
        } else {
            return Image(systemName: "star.fill")
        }
    }
}
