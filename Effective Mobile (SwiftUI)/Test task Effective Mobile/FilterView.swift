//
//  FilteredView.swift
//  Test task Effective Mobile
//
//  Created by Илья Синицын on 18.09.2022.
//

import SwiftUI

struct FilterView: View {
    @Binding var isActive: Bool
    var brand = ["Samsung"]
    var price = ["$0 - $10000"]
    var size = ["4.5 to 5.5 inches"]
    @State private var selectedBrand = 0
    @State private var selectedPrice = 0
    @State private var selectedSize = 0
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack {
                    Button {
                        print("Close filter")
                        isActive.toggle()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .frame(width: 37, height: 37)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(10)
                    .padding(.leading, 44)
                    
                    Spacer()
                    
                    Text("Filter options")
                        .font(.system(size: 18)).bold()
                    
                    Spacer()
                    
                    Button {
                        print("Filter done")
                    } label: {
                        Text("Done")
                    }
                    .frame(width: 86, height: 37)
                    .foregroundColor(.white)
                    .background(Color("orange"))
                    .cornerRadius(10)
                    .padding(.trailing, 20)
                }
            }
            .padding(.top, -5)
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("Brand")
                            .font(.system(size: 18)).bold()
                            .foregroundColor(.black)
                           
                        Spacer ()
                    }
                    .padding(.leading, 46)
                    
                    Menu {
                        Picker("Brand", selection: $selectedBrand) {
                            ForEach(0 ..< brand.count) {
                                Text(self.brand[$0])
                            }
                        }
                    } label: {
                        HStack {
                            Rectangle()
                                .foregroundColor(Color(.systemBackground))
                                .frame(height: 40)
                            Image(systemName: "chevron.down")
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                                .foregroundColor(Color("gray"))
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color("gray"), lineWidth: 1)
                        )
                        .overlay(
                            Text("\(brand[selectedBrand])")
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 0, leading: -140, bottom: 0, trailing: 0))
                        )
                        .padding(EdgeInsets(top: 5, leading: 46, bottom: 0, trailing: 20))
                    }
                }
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("Price")
                            .font(.system(size: 18)).bold()
                            .foregroundColor(.black)
                        
                        Spacer ()
                    }
                    .padding(.leading, 46)
                    
                    Menu {
                        Picker("Price", selection: $selectedPrice) {
                            ForEach(0 ..< price.count) {
                                Text(self.price[$0])
                            }
                        }
                    } label: {
                        HStack {
                            Rectangle()
                                .foregroundColor(Color(.systemBackground))
                                .frame(height: 40)
                            Image(systemName: "chevron.down")
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                                .foregroundColor(Color("gray"))
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color("gray"), lineWidth: 1)
                        )
                        .overlay(
                            Text("\(price[selectedPrice])")
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 0, leading: -140, bottom: 0, trailing: 0))
                        )
                        .padding(EdgeInsets(top: 5, leading: 46, bottom: 0, trailing: 20))
                    }
                }
                .padding(.top, 10)
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("Size")
                            .font(.system(size: 18)).bold()
                            .foregroundColor(.black)
                        
                        Spacer ()
                    }
                    .padding(.leading, 46)
                    
                    Menu {
                        Picker("Size", selection: $selectedSize) {
                            ForEach(0 ..< size.count) {
                                Text(self.size[$0])
                            }
                        }
                    } label: {
                        HStack {
                            Rectangle()
                                .foregroundColor(Color(.systemBackground))
                                .frame(height: 40)
                            Image(systemName: "chevron.down")
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                                .foregroundColor(Color("gray"))
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color("gray"), lineWidth: 1)
                        )
                        .overlay(
                            Text("\(size[selectedSize])")
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 0, leading: -140, bottom: 0, trailing: 0))
                        )
                        .padding(EdgeInsets(top: 5, leading: 46, bottom: 0, trailing: 20))
                    }
                }
                .padding(.top, 10)
            }
            .padding(.top, 5)
            
            Spacer()
        }
        .padding(.top, 24)
        .frame(height: 311)
        .background(.white)
        .cornerRadius(30)
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStoreView()
            .environmentObject(NetworkServiceManager())
    }
}
