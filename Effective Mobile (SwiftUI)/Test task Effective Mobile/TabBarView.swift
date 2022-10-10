//
//  TabBarView.swift
//  Test task Effective Mobile
//
//  Created by Илья Синицын on 07.10.2022.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        ZStack {
            Color("black")
            
            HStack {
                HStack {
                    Button {
                        print("Tap tabbar itm 0")
                    } label: {
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(.white)
                        Text("Explorer")
                            .foregroundColor(.white)
                            .font(.system(size: 15)).bold()
                    }
                    .frame(width: 76, height: 19)
                    .padding(.leading, 68)
                }
                
                Button {
                    print("Tap tabbar itm  1")
                } label: {
                    Image("cart")
                        .resizable()
                        .frame(width: 17.54, height: 18)
                        .foregroundColor(.white)
                }
                .padding(.leading, 47)
                
                Button {
                    print("Tap tabbar itm  2")
                } label: {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 19, height: 17)
                        .foregroundColor(.white)
                }
                .padding(.leading, 52)
                
                Button {
                    print("Tap tabbar itm  3")
                } label: {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 17.01, height: 17.57)
                        .foregroundColor(.white)
                }
                .padding(.leading, 52)
                .padding(.trailing, 67)
            }
        }
        .frame(width: 414, height: 72)
        .cornerRadius(30)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
