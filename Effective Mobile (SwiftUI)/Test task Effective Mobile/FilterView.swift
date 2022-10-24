//
//  FilteredView.swift
//  Test task Effective Mobile
//
//  Created by Илья Синицын on 18.09.2022.
//

import SwiftUI

struct FilterView: View {
    @Binding var isActiveFilterView: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var brand = ["Samsung"]
    var price = ["$0 - $10000"]
    var size = ["4.5 to 5.5 inches"]
    let width: CGFloat = UIScreen.main.bounds.width
    @State private var selectedBrand = 0
    @State private var selectedPrice = 0
    @State private var selectedSize = 0
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Button {
                        isActiveFilterView.toggle()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .frame(width: 37, height: 37)
                    .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                    .background(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    Text("Filter options")
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    Button {
                        print("Filter done")
                    } label: {
                        Text("Done")
                    }
                    .frame(width: 86, height: 37)
                    .foregroundColor(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                    .background(Color(UIColor(red: 1, green: 0.429, blue: 0.304, alpha: 1).cgColor))
                    .cornerRadius(10)
                    .padding(.trailing, 20)
                }
                .padding(.top, 24)
                
                FilteredView(selectedIndex: $selectedBrand, text: "Brand", array: brand)
                    .padding(.top, 40)
              
                FilteredView(selectedIndex: $selectedPrice, text: "Price", array: price)
                    .padding(.top, 10)
                
                FilteredView(selectedIndex: $selectedSize, text: "Size", array: size)
                    .padding(.top, 10)
                
                Spacer()
            }
            .padding(.leading, 44)
        }
        .frame(width: width, height: 375)
        .background(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
        .shadow(color: Color(UIColor(red: 0.298, green: 0.372, blue: 0.562, alpha: 0.2).cgColor), radius: 20)
        .cornerRadius(30)
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(isActiveFilterView: .constant(true))
    }
}

struct FilteredView: View {
    @Binding var selectedIndex: Int
    let text: String
    let array: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(text)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
                
            Menu {
                Picker(text, selection: $selectedIndex) {
                    ForEach(array, id: \.self) { index in
                        Text(index)
                            .font(.system(size: 18))
                            .fontWeight(.regular)
                            .foregroundColor(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
                    }
                }
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(UIColor(red: 0.863, green: 0.863, blue: 0.863, alpha: 1).cgColor), lineWidth: 1)
                            .foregroundColor(Color.white)
                            .frame(height: 37)
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color(UIColor(red: 0.702, green: 0.702, blue: 0.702, alpha: 1).cgColor))
                            .padding(.leading, 250)
                    }
                }
                .overlay(
                    Text("\(array[selectedIndex])")
                        .font(.system(size: 18))
                        .fontWeight(.regular)
                        .foregroundColor(Color(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1).cgColor))
                        .padding(.leading, -140)
                )
            }
            .frame(width: 310, height: 37)
            .padding(.top, 5)
        }
    }
}
