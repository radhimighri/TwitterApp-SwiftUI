//
//  ContentView.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 04/02/2022.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @State private var showMenu = false
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        
        Group {
            //no user is logged in
            if authViewModel.userSession == nil {
                LoginView()
            } else {
                //have a logged in user
                mainInterfaceView
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension ContentView {
    var mainInterfaceView: some View {
        ZStack(alignment: .topLeading) {
            MainTabView()
                .navigationBarHidden(showMenu)
            
            //shadow view
            if showMenu {
                ZStack {
                    Color(.black)
                        .opacity(showMenu ? 0.25 : 0.0)
                }.onTapGesture {
                    withAnimation(.easeInOut) {
                        showMenu = false
                    }
                }
                .ignoresSafeArea()
            }
            
            SideMenuView()
                .frame(width: 300)
                .offset(x: showMenu ? 0 : -300, y: 0)
                .background(showMenu ? Color.white : Color.clear)
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    withAnimation(.easeInOut) {
                        showMenu.toggle()
                    }
                } label: {
                    if let user = authViewModel.currentUser {
//                        Circle()
//                            .frame(width: 32, height: 32)
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 32, height: 32)
                            .background(Color(.systemBlue))
                            .clipShape(Circle())
//                            .cornerRadius(32/2)


                    }
                }

            }
        }
        .onAppear { //close SideMenu when come back to the main zStack
            showMenu = false
        }
    }
}
