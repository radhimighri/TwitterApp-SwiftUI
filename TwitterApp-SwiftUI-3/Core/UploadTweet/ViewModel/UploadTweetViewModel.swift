//
//  UploadTweetViewModel.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 10/02/2022.
//


import SwiftUI
import Firebase
//

class UploadTweetViewModel: ObservableObject {
    private let service = TweetService()
    @Published var didUploadTweet = false
    
        func uploadTweet(withCaption caption: String) {
            service.uploadTweet(caption: caption) { success in
                if success {
                    //dismiss screen somehow
                    self.didUploadTweet = true
                } else {
                    self.didUploadTweet = false
                }
            }
        }

}
