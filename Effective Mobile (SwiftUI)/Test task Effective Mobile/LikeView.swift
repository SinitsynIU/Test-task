//
//  SwiftUIView.swift
//  Test task Effective Mobile
//
//  Created by Илья Синицын on 11.10.2022.
//

import SwiftUI

struct LikeView: View {
    let width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack(spacing: 0) {
                Text("Like!")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 350)
                
                Spacer()
            }
            .frame(width: width)
        }
        .ignoresSafeArea()
    }
}

struct LikeView_Previews: PreviewProvider {
    static var previews: some View {
        LikeView()
    }
}
