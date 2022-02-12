//
//  User.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 10/02/2022.
//

import FirebaseFirestoreSwift
import FirebaseAuth

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let profileImageUrl: String
    let email: String
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id }
}
