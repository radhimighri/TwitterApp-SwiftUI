//
//  ProfileViewModel.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 12/02/2022.
//

import Foundation


class ProfileViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    @Published var likedTweets = [Tweet]()
    
    private let service = TweetService()
    private let userService = UserService()

    let user: User
    
    
    //pass the object and initialise it : dependency injection
    init(user: User) {
        self.user = user
        self.fetchUserTweets()
        self.fetchLikedTweets()
    }
    
    var actionButtonTitle: String {
        return user.isCurrentUser ? "Edit Profile" : "Follow"
    }
    
    func tweets(forFilter filter: TweetFilterViewModel) -> [Tweet] {
        switch filter {
        case .tweets:
            return tweets
        case .replies:
            return tweets
        case .likes:
            return likedTweets
        }
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
    
    func fetchLikedTweets(){
        guard let uid = user.id else {return}
        service.fetchLikedTweets(forUid: uid) { tweets in
            self.likedTweets = tweets
            
            for i in 0 ..< tweets.count {
                let userID = tweets[i].userID
                
                self.userService.fetchUser(withUID: userID) { user in
                    self.likedTweets[i].user = user
                }
            }

        }
    }
}
