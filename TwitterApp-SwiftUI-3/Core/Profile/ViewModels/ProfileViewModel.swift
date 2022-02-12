//
//  ProfileViewModel.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 12/02/2022.
//

import Foundation


class ProfileViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    private let service = TweetService()
    let user: User
    
    
    //pass the object and initialise it : dependency injection
    init(user: User) {
        self.user = user
        self.fetchUserTweets()
    }
    
    func fetchUserTweets() {
        guard let uid = user.id else {return}
        service.fetchTweets(forUID: uid) { tweets in
            self.tweets = tweets
            
            for i in 0 ..< tweets.count {
                self.tweets[i].user = self.user
            }
        }
    }
}
