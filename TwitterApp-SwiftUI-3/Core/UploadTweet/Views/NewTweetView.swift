//
//  NewTweetView.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 07/02/2022.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    @State private var caption = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var uploadTweetVM = UploadTweetViewModel()

    var body: some View {

        VStack {
            //buttons
            HStack {
                
                Button {
                    print("DEBUG: Dismiss")
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color(.systemBlue))
                }
                
                Spacer()
                
                Button {
                    print("DEBUG: Tweet")
                    uploadTweetVM.uploadTweet(withCaption: caption)
                     
                } label: {
                    Text("Tweet")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(.systemBlue))
                        .foregroundColor(Color.white)
                        .clipShape(Capsule())
                }

            }
            .padding()
            
            HStack(alignment: .top) {

                if let user = authViewModel.currentUser {
//                    Circle()
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 64, height: 64)

                }
                
                TextArea("What's happening?", text: $caption)
                
            }
            .padding()
        }
        .onReceive(uploadTweetVM.$didUploadTweet) { success in
            
            if success {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView()
    }
}
