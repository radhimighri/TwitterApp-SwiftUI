//
//  ProfileView.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 07/02/2022.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @State private var selectedFilter: TweetFilterViewModel = .tweets
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var profileVM: ProfileViewModel
    @Namespace var animation
    @EnvironmentObject var authViewModel: AuthViewModel
//    private let user: User
    
    //dependency injection (custom initialiser)
    init(user: User) {
//        self.user = user
        self.profileVM = ProfileViewModel(user: user)
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            headerView
            
            actionButtons
            
            userInfoDetails
            
            tweetFilterBar
            
            tweetsView
            
            Spacer()
            
        }
        .navigationBarHidden(true) //hide the nav bar, we can't swipe to right to dismiss
        
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}


// to keep th main body nice and clean, i've create this extension
extension ProfileView {
    
    var headerView: some View {
        ZStack(alignment: .bottomLeading) {
            Color(.systemBlue)
                .ignoresSafeArea()
        
            VStack {
                
                Button {
                    //
                    print("DEBUG: Back button got taped..")
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 16)
                        .foregroundColor(.white)
                        .offset(x: 16, y: -4)
                }

//                if let user = authViewModel.currentUser {
//                    Circle()
//                        .frame(width: 72, height: 72)
//                    .offset(x: 16, y: 24)
                KFImage(URL(string: profileVM.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 72, height: 72)
                    .offset(x: 16, y: 24)

//                }
            }
        }
        .frame(height: 96)
    }
    
    var actionButtons: some View {
        
        HStack(spacing: 12) {
            Spacer()
            
            Image(systemName: "bell.badge")
                .font(.title3)
                .padding(6)
                .overlay(Circle().stroke(Color.gray, lineWidth: 0.75))
        
            Button {
                
            } label: {
                Text("Edit Profile")
                    .font(.subheadline)
                    .bold()
                    .frame(width: 120, height: 32)
                    .foregroundColor(.black)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
            }
        }
        .padding(.trailing)

    }
    
    var userInfoDetails: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(profileVM.user.fullname)
                    .font(.title2)
                    .bold()
                
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(Color(.systemBlue))
            }
            
            Text("@\(profileVM.user.username)")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("Your moms favorite villain")
                .font(.subheadline)
                .padding(.vertical)
            
            HStack(spacing: 24) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    
                    Text("Gotham, NY")
                }
                
                HStack {
                    Image(systemName: "link")
                    
                    Text("www.thejocker.com")
                    
                }
            }
            .font(.caption)
            .foregroundColor(.gray)
            
            
            
            UserStatsView()
                .padding(.vertical)

            
            
            
        }
        .padding(.horizontal)

    }
    
    var tweetFilterBar: some View {
        HStack {
            ForEach(TweetFilterViewModel.allCases, id: \.rawValue) { item in
                VStack {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? .black : .gray)
                    
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(Color(.systemBlue))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation) // adding the slide animation
                    } else {
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x:0, y:16))

    }
    
    var tweetsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(profileVM.tweets) { tweet in
                    TweetRowView(tweet: tweet)
                        .padding()
                }
            }
        }

    }
}
