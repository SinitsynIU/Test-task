//
//  CartView.swift
//  Test task Effective Mobile
//
//  Created by Илья Синицын on 10.10.2022.
//

import SwiftUI

struct CartView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var cartManager: CartManager
    let width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                CartNaviganionBarView()
                
                HeaderView()
                    .padding(.top, 40)
                
                Spacer()
                
                VStack(spacing: 0)  {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 35) {
                            ForEach(cartManager.products, id: \.id) { index in
                                ProductView(product: index)
                            }
                        }
                    }
                    .frame(width: width,height: 320)
                    .padding(.top, 35)
                    
                    Divider()
                        .frame(width: 380, height: 2)
                        .background(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor))
                        .padding(.top, 6)
                    
                    CartTotalView()
                    
                    Divider()
                        .frame(width: 414, height: 1)
                        .background(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.2).cgColor))
                        .padding(.top, 26)
                    
                    Button {
                        print("Checkout")
                    } label: {
                        HStack {
                            Text("Checkout")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                        }
                    }
                    .frame(width: 326, height: 54)
                    .background(Color(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1).cgColor))
                    .cornerRadius(10)
                    .padding(.top, 27)
                }
                .frame(width: width, height: 610)
                .background(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
                .cornerRadius(30)
                .shadow(color: Color(UIColor(red: 0.298, green: 0.372, blue: 0.562, alpha: 0.1).cgColor), radius: 20)
                .padding(.top, 40)
            }
            .padding(.top, 79)
            .navigationBarBackButtonHidden()
        }
        .ignoresSafeArea()
        .background(Color(UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1).cgColor))
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}

struct CartNaviganionBarView: View {
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
            
            Text("Add address")
                .font(.system(size: 15))
                .fontWeight(.medium)
                .foregroundColor(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
                .padding(.trailing, 9)
            
            Button {
                print("Map open")
            } label: {
                Image("map2")
                    .resizable()
                    .frame(width: 14, height: 17.87)
            }
            .frame(width: 37, height: 37)
            .background(Color(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1).cgColor))
            .cornerRadius(10)
            .padding(.trailing, 46)
        }
    }
}

struct HeaderView: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("My Cart")
                .font(.system(size: 35)).bold()
                .foregroundColor(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
            
            Spacer()
        }
        .padding(.leading, 42)
    }
}

struct ProductView: View {
    @EnvironmentObject var cartManager: CartManager
    @State var stepperValue: Int = 0
    @State var product: Basket
    private let width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor)
                
                AsyncImage(url: URL(string: product.images ?? "")) { imageUrl in
                    if let image = imageUrl.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 88, height: 88)
                            .clipped()
                    }
                }
            }
            .frame(width: 88, height: 88)
            .overlay(
                RoundedRectangle (cornerRadius: 17)
                    .stroke(lineWidth: 0.5)
            )
            .cornerRadius(17)
            .shadow(radius: 5)
            .padding(.leading, 33)
        
            VStack(alignment: .leading, spacing: 0) {
                Text("\(product.title ?? "")")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                
                Text("$\(product.price ?? 0).00")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(Color(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1).cgColor))
                    .padding(.top, 7)
                
                Text(product.count?.description ?? "0")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(Color(UIColor(red: 1, green: 0.429, blue: 0.3004, alpha: 1).cgColor))
                    .padding(.top, 7)
            }
            .frame(height: 88)
            .padding(.leading, 17)
            
            Spacer()
            
            StepperView(text: product.count ?? 0, value: $stepperValue, range: 1...100, step: 1, onIncrement: {
                product.count = stepperValue
                cartManager.onIncrementCat(product: product)
            }, onDecrement: {
                product.count = stepperValue
                cartManager.onDecrementCat(product: product)
            })
            .padding(.trailing, 17)
            
            Button {
                print("Remove item")
                cartManager.removeProductFromCat(product: product)
            } label: {
                Image("remove")
                    .resizable()
                    .frame(width: 14.75,height: 16)
                    .foregroundColor(Color(UIColor(red: 0.213, green: 0.211, blue: 0.3, alpha: 1).cgColor))
            }
            .padding(.trailing, 32)
        }
        .frame(width: width)
    }
}

struct CartTotalView: View {
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Total")
                    .font(.system(size: 15))
                    .fontWeight(.regular)
                    .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                
                Text("Delivery")
                    .font(.system(size: 15))
                    .fontWeight(.regular)
                    .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                    .padding(.top, 12)
            }
            .padding(.leading, 55)
            .padding(.top, 15)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 0) {
                Text("$\(cartManager.total) us")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                    .environmentObject(cartManager)
                
                Text(cartManager.delivery)
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                    .padding(.top, 12)
                    .environmentObject(cartManager)
            }
            .padding(.trailing, 35)
            .padding(.top, 15)
        }
    }
}
