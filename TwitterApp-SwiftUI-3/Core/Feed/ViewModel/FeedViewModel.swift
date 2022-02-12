//
//  FeedViewModel.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 10/02/2022.
//

import Foundation


class FeedViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    let service = TweetService()
    let userService = UserService()
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        service.fetchTweets { tweets in
            self.tweets = tweets
            
            for i in 0 ..< tweets.count {
                let userID = tweets[i].userID
                
                self.userService.fetchUser(withUID: userID) { user in
                    self.tweets[i].user = user
                }
            }
        }
    }
}
