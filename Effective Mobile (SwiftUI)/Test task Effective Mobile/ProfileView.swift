//
//  ProfileView.swift
//  Test task Effective Mobile
//
//  Created by Илья Синицын on 11.10.2022.
//

import SwiftUI

struct ProfileView: View {
    let width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack(spacing: 0) {
                Text("Profile")
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
