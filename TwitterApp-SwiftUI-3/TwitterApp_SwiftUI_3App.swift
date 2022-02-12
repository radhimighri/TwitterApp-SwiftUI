//
//  TwitterApp_SwiftUI_3App.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 04/02/2022.
//

import SwiftUI
import Firebase

@main
struct TwitterApp_SwiftUI_3App: App {
    
    //initialise the Authentication viewModel
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
        
        //desable autolayout warnings logs
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
    }
    
    var body: some Scene {
        WindowGroup {

            NavigationView {
//                LoginView()
                ContentView()
//                ProfilePhotoSelectorView()
            }
            .environmentObject(viewModel)
        }
    }
}
