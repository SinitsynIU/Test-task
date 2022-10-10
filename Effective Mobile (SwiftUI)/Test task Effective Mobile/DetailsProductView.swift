//
//  DetailProductView.swift
//  Test task Effective Mobile
//
//  Created by Илья Синицын on 07.10.2022.
//

import SwiftUI

struct DetailsProductView: View {
    @Binding var isActiveView: Bool
    let detailsModels: [ProductDetailsModel]
    
    var body: some View {
        ZStack {
            Color("bg")
            
            VStack(spacing: 0) {
                DetailsProductNaviganionBarView(isActive: $isActiveView)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 29) {
                        ForEach(0 ..< (detailsModels.first?.images.count ?? 0)) { index in
                            GeometryReader { geometry in
                               
                                    let  scale = getScaleFactor(proxy: geometry)
                                                          
                                ImageView(image: detailsModels.first?.images[index] ?? "")
                                        .scaleEffect(CGSize(width: scale, height: scale))
                                        .offset(x: -15)
                            }
                            .frame(width: 199, height: 279)
                        }
                    }
                    .padding(32)
                }
                
                VStack(spacing: 0) {
                    HStack {
                        Text("Galaxy Note 20 Ultra")
                            .font(.system(size: 24).bold())
                            .padding(.leading, 38)
                        
                        Spacer()
                        
                        Button {
                            print("Like")
                        } label: {
                            Image(systemName: (detailsModels.first?.isFavorites ?? false) ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 14, height: 13)
                        }
                        .frame(width: 37, height: 37)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(10)
                        .padding(.trailing, 37)
                   
                    }
                    .padding(.top, 28)
                    
                    HStack {
                        ForEach(0 ..< Int(detailsModels.first?.rating ?? 0.0)) { index in
                            Image(systemName: "star.fill")
                                .frame(width: 18, height: 18)
                                .foregroundColor(.yellow)
                        }
                        
                    Spacer()
                        
                    }
                    .padding(.top, 7)
                    .padding(.leading, 38)
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    Spacer()
                }
                .frame(width: 414, height: 471)
                .background(Color.white)
                .cornerRadius(50)
            }
            .padding(.top, 79)
        }
        .ignoresSafeArea()
    }
    
    func getScaleFactor(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        let x = proxy.frame(in: .global).minX
        let diff = abs(x - 100)
        if diff > 100 {
            scale = 1 + (100 - diff) / 500
        }
        return scale
    }
}

struct DetailsProductView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStoreView()
            .environmentObject(NetworkServiceManager())
    }
}

struct DetailsProductNaviganionBarView: View {
    @Binding var isActive: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    print("Back")
                    isActive.toggle()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .frame(width: 37, height: 37)
                .foregroundColor(.white)
                .background(.black)
                .cornerRadius(10)
                .padding(.leading, 42)
                
                Spacer()
                
                Text("Product Details")
                    .font(.system(size: 18)).bold()
                
                Spacer()
                
                Button {
                    print("Add cart")
                } label: {
                    Image("cart")
                        .resizable()
                        .frame(width: 13.64,height: 14)
                }
                .frame(width: 37, height: 37)
                .foregroundColor(.white)
                .background(Color("orange"))
                .cornerRadius(10)
                .padding(.trailing, 35)
            }
        }
    }
}

struct ImageView: View {
    let image: String
    
    var body: some View {
        AsyncImage(url: URL(string: image)) { imageUrl in
            if let image = imageUrl.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 220)
                    .clipped()
                    .overlay(
                        RoundedRectangle (cornerRadius: 17)
                            .stroke(lineWidth: 0.5)
                    )
                    .cornerRadius(17)
                    .shadow(radius: 5)
            }
        }
    }
}
