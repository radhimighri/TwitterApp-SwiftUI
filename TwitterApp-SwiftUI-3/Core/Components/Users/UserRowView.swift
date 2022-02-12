//
//  UserRowView.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 07/02/2022.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    let user: User
    
    var body: some View {

        HStack(spacing: 12) {
//            Circle()
//                .frame(width: 48, height: 48)
            KFImage(URL(string: user.profileImageUrl))
            .resizable()
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: 56, height: 56)

            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.username)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .bold()
                
                Text(user.fullname)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
        
        
    }
}
//
//struct UserRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserRowView()
//    }
//}
