//
//  TweetRowView.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 07/02/2022.
//

import SwiftUI
import Kingfisher

struct TweetRowView: View {
    
//    let tweet: Tweet
    
    @ObservedObject var tweetViewModel: TweetRowViewModel
    
    init(tweet: Tweet) {
        self.tweetViewModel = TweetRowViewModel(tweet: tweet)
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            //profile image + user info + tweet caption
            if let user = tweetViewModel.tweet.user {
            HStack(alignment: .top, spacing: 12) {
                KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                //user info & tweet caption
                VStack (alignment: .leading, spacing: 4){
                    
                    //user info
                        HStack {
                            Text(user.fullname)
                                .font(.subheadline)
                                .bold()
                            
                            Text("@\(user.username)")
                                .foregroundColor(.gray)
                                .font(.caption)
                            
                            Text("2w")
                                .foregroundColor(.gray)
                                .font(.caption)
                        

                    }
                    //Tweet caption
                    Text(tweetViewModel.tweet.caption)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                }
            }
            }
            //action buttons
            HStack {
                Button {
                    //action goes here
                } label: {
                    Image(systemName: "bubble.left")
                        .font(.subheadline)
                }
                Spacer()
                
                Button {
                    //action goes here
                } label: {
                    Image(systemName: "arrow.2.squarepath")
                        .font(.subheadline)
                }
                Spacer()

                
                Button {
                    tweetViewModel.tweet.didLike ?? false ?
                    tweetViewModel.unlikeTweet() :
                    tweetViewModel.likeTweet()
                } label: {
                    Image(systemName: tweetViewModel.tweet.didLike ?? false ? "heart.fill" : "heart")
                        .font(.subheadline)
                        .foregroundColor(tweetViewModel.tweet.didLike ?? false ? .red : .gray)
                }
                Spacer()

                Button {
                    //action goes here
                } label: {
                    Image(systemName: "bookmark")
                        .font(.subheadline)
                }
                
            }
            .padding()
            .foregroundColor(.gray)
            
            Divider()

        }
        
    }
}

//struct TweetRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TweetRowView()
//    }
//}
