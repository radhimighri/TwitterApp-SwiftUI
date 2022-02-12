//
//  RegistrationView.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 07/02/2022.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel

    
    var body: some View {

        //parent container
        VStack{
            
            NavigationLink(destination: ProfilePhotoSelectorView(),
                           isActive: $viewModel.didAuthenticateUser,
                           label: { })

            
            AuthHeaderView(title1: "Get Started.", title2: "Create your account")

            VStack(spacing: 40) {
                
                CustomInputField(iconName: "envelope",
                                 placeholderText: "Email",
                                 text: $email)
                
                CustomInputField(iconName: "person",
                                 placeholderText: "Username",
                                 text: $username)

                
                CustomInputField(iconName: "person",
                                 placeholderText: "Full name",
                                 text: $fullname)

                
                CustomInputField(iconName: "lock",
                                 placeholderText: "Password",
                                 isSecureField: true,
                                 text: $password)

//                CustomSecureInputField(iconName: "lock",
//                                       placeholderText: "Password",
//                                       text: $password)

            }
            .padding(32)
            
            Button {
//                print("DEBUG: Sign up here..")
                viewModel.register(withEmail: email,
                                   password: password,
                                   fullname: fullname,
                                   username: username)
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)

            
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                        .font(.footnote)
                    
                    Text("Sign In")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
            
        }
        .ignoresSafeArea()
        
        
        
    }
    
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
