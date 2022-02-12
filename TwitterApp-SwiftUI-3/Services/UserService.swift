//
//  API.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 09/02/2022.
//

import Firebase
import FirebaseFirestoreSwift
 
struct UserService {
    
    func fetchUser(withUID uid: String, completion: @escaping(User) -> Void) {
//         print("DEBUG: Fetch user info..")
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else {return}
                guard let user = try? snapshot.data(as: User.self) else {return}
                completion(user)
//                print("DEBUG: Username is \(user.username)")
            }
    }
    
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
//        var users = [User]()
        
//        Firestore.firestore().collection("users")
//            .getDocuments(completion: { snapshot, _ in
//
//                guard let docs = snapshot?.documents else {return}
//                docs.forEach { doc in
//                    guard let user = try? doc.data(as: User.self) else {return}
//                    users.append(user)
//                }
//
//                completion(users)
//            })
        Firestore.firestore().collection("users")
            .getDocuments(completion: { snapshot, _ in
                guard let docs = snapshot?.documents else {return}
                //short hand method to map our users models
                let users = docs.compactMap({ try? $0.data(as: User.self) })
                completion(users)
            })
            }
    
    

}
