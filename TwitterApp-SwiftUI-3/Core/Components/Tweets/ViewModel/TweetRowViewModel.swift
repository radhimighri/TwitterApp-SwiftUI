//
//  TweetRowViewModel.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 12/02/2022.
//

import Foundation

//in order to no passing the service instances directly into the views, we must always use viewModels (MVVM)


class TweetRowViewModel: ObservableObject {
    @Published var tweet: Tweet
    private let service = TweetService()

    
    init(tweet: Tweet) {
        self.tweet = tweet
        checkIfUserLikedTweet()
    }
    
    func likeTweet() {
        service.likeTweet(tweet) {
            self.tweet.didLike = true
        }
    }
    
    //used to show all the liked tweets when launching the app (persist it on the UI)
    func checkIfUserLikedTweet() {
        service.checkIfUserLikedTweet(tweet) { didLike in
            if didLike{
                self.tweet.didLike = true
            }
        }
    }
    
    func unlikeTweet() {
        service.unlikeTweet(tweet) {
            self.tweet.didLike = false
        }
    }
}
