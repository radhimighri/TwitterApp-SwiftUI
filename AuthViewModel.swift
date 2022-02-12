//
//  AuthViewModel.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 09/02/2022.
//

import SwiftUI
//import FirebaseFirestore
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    @Published var tempUserSession: FirebaseAuth.User?
    @Published var currentUser: User?

    private let service = UserService()

    init() {
        self.userSession = Auth.auth().currentUser
        
//        print("DEBUG: User session is \(self.userSession?.uid)")
        self.fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
//        print("DEBUG: Login with email:  \(email)")

        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let err = error {
                print("DEBUG: Failed to sign in with error \(err.localizedDescription)")
                return
            }

            guard let user = result?.user else {return}
            self.userSession = user
//            print("DEBUG: Did log user in..")
            // to show the data of the new created user
            self.fetchUser()
        }
    }
    
    func register(withEmail email: String, password: String, fullname: String, username: String) {
//        print("DEBUG: Register with email \(email)")

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let err = error {
                print("DEBUG: Failed to register with error \(err.localizedDescription)")
                return
            }
            
            guard let user = result?.user else {return}
//            print("DEBUG: Registred user successfully")
//            print("DEBUG: User is \(String(describing: self.userSession))")
            self.tempUserSession = user
            
            let regData = [
                "email": email,
                "username": username.lowercased(),
                "fullname": fullname,
                "uid": user.uid
            ]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(regData) { _ in
                    print("DEBUG: Did upload user data..")
                    self.didAuthenticateUser = true
                }

            
        }
    }
    
    func signOut() {
        //set user session to nil so we show login view (frontend side)
        userSession = nil
        
        //signs user out on server side
        try? Auth.auth().signOut()
    }
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else {return}
         
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]) { _ in
                    self.userSession = self.tempUserSession
                    
                    // to show the data of the new created user
                    self.fetchUser()
                }
        }
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else {return}
        service.fetchUser(withUID: uid) { user in
            self.currentUser = user
        }
    }
}
