//
//  Tweet.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 10/02/2022.
//

import FirebaseFirestoreSwift
import Firebase

struct Tweet: Identifiable, Decodable {
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let userID: String
    let likes: Int
    
    var user: User?
    var didLike: Bool? = false
    
}
