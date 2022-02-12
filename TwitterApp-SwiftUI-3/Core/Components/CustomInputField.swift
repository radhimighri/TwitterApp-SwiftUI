//
//  CustomInputField.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 08/02/2022.
//

import SwiftUI

struct CustomInputField: View {
    let iconName: String
    let placeholderText: String
    var isSecureField: Bool? = false
    @Binding var text: String
    
    var body: some View {
        
        VStack {
            HStack {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                if isSecureField ?? false {
                    SecureField(placeholderText, text: $text)
                } else {
                    TextField(placeholderText, text: $text)
                }
                
            }
            Divider()
                .background(Color(.darkGray))
        }
    }
}

//struct CustomSecureInputField: View {
//    let iconName: String
//    let placeholderText: String
//    @Binding var text: String
//
//    var body: some View {
//
//        VStack {
//            HStack {
//                Image(systemName: iconName)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 20, height: 20)
//                    .foregroundColor(Color(.darkGray))
//
//                SecureField(placeholderText, text: $text)
//            }
//            Divider()
//                .background(Color(.darkGray))
//        }
//    }
//}


struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(iconName: "envelope",
                         placeholderText: "Email",
                         text: .constant(""))
    }
}
