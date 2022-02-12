//
//  LoginView.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 07/02/2022.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {

        //parent container
        VStack {
            
            //header view
            AuthHeaderView(title1: "Hello.", title2: "Welcome Back!")
            
            VStack(spacing: 40) {
                CustomInputField(iconName: "envelope",
                                 placeholderText: "Email",
                                 text: $email)
                
                CustomInputField(iconName: "lock",
                                 placeholderText: "Password",
                                 isSecureField: true,
                                 text: $password)
                                
//                CustomSecureInputField(iconName: "lock",
//                                       placeholderText: "Password",
//                                       text: $password)
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 44)
            
            //forgot password
            HStack {
                Spacer()
                
                NavigationLink {
                    Text("Reset password view..")
                } label: {
                    Text("Forgot Password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                        .padding(.top)
                        .padding(.trailing, 24)
                }
            }

            Button {
//                print("DEBUG: Sign in here..")
                viewModel.login(withEmail: email, password: password)
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            
            NavigationLink {
                RegistrationView()
                    .navigationBarHidden(true)
            } label: {
                HStack {
                    Text("Don't have an account yet?")
                        .font(.footnote)
                    
                    Text("Sign Up")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
            .foregroundColor(Color(.systemBlue))
        }
        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
          LoginView()
    }
}
