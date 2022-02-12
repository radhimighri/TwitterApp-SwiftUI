//
//  TweetService.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 10/02/2022.
//

import Firebase
import FirebaseFirestore

struct TweetService {
    
    func uploadTweet(caption: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let tweetData = ["userID": uid,
                         "caption": caption,
                         "likes": 0,
                         "timestamp": Timestamp(date: Date())
        ] as [String: Any]
        
        Firestore.firestore().collection("tweets").document()
            .setData(tweetData) { error in
                if let err = error {
                    print("DEBUG: Failed to upload tweet with error: \(err.localizedDescription)")
                    completion(false)
                    return
                }
                print("DEBUG: Tweet was uploaded with success...")
                completion(true)
                }
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        Firestore.firestore().collection("tweets")
            .order(by: "timestamp", descending: true)//filter on the server side to make the app more light
            .getDocuments { snapshot, _ in
            guard let docs = snapshot?.documents else {return}
            
            let tweets = docs.compactMap({ try? $0.data(as: Tweet.self) })
            completion(tweets)
        }
    }
    
    
    
    func fetchTweets(forUID uid: String, completion: @escaping(([Tweet])-> Void)) {
        Firestore.firestore().collection("tweets")
            .whereField("userID", isEqualTo: uid)
//            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
            guard let docs = snapshot?.documents else {return}
            
            let tweets = docs.compactMap({ try? $0.data(as: Tweet.self) })
//            completion(tweets)
            completion(tweets.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })) //filter on the client side because firestore doesen't has the capabilty to apply more than 1 filter
        }
    }
    
}

//MARK: - Likes
extension TweetService {
    
    func likeTweet(_ tweet: Tweet, completion: @escaping()-> Void) {
        print("DEBUG: Like tweet here..")
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let tweetID = tweet.id else {return}
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")

        
        Firestore.firestore().collection("tweets").document(tweetID)
            .updateData(["likes": tweet.likes + 1]) { _ in
                userLikesRef.document(tweetID).setData([:]) {_ in
                    print("DEBUG: Did like tweet and now we should update UI")
                    completion()
                }
            }

    }
    
    func unlikeTweet(_ tweet: Tweet, completion: @escaping()-> Void) {
        print("DEBUG: Unlike tweet here..")
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let tweetID = tweet.id else {return}
        guard tweet.likes > 0 else {return} //make sure that the tweets likes more than 0 to avoid decrementing into negative values (Additional logic check)

        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")

        
        Firestore.firestore().collection("tweets").document(tweetID)
            .updateData(["likes": tweet.likes - 1]) { _ in
                userLikesRef.document(tweetID).setData([:]) {_ in
                    print("DEBUG: Did unlike tweet and now we should update UI")
                    userLikesRef.document(tweetID).delete { _ in
                        completion()
                    }
                }
            }
        
    }
    
    
    func checkIfUserLikedTweet(_ tweet: Tweet, completion: @escaping(Bool)-> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let tweetID = tweet.id else {return}

        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .document(tweetID).getDocument { snapshot, _ in
                guard let snap = snapshot else {return}
                completion(snap.exists)
            }

    }
    

    func fetchLikedTweets(forUid uid: String, completion: @escaping([Tweet])-> Void) {
        
        var tweets = [Tweet]()
        print("DEBUG: Fetch liked tweets here..")
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .getDocuments { snapshot, _ in
                guard let docs = snapshot?.documents else {return}

                docs.forEach { doc in
                    let tweetID = doc.documentID
                    
                    Firestore.firestore().collection("tweets")
                        .document(tweetID)
                        .getDocument { snapshot, _ in
                            guard let tweet = try? snapshot?.data(as: Tweet.self) else { return }
                            tweets.append(tweet)
                            completion(tweets)
                        }
                }
            }

    }
    
}
