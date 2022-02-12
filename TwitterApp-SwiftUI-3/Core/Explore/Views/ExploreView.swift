//
//  ExploreView.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 07/02/2022.
//

import SwiftUI

struct ExploreView: View {
    @ObservedObject var exploreViewModel = ExploreViewModel()
    
    var body: some View {

//        NavigationView {
                
            VStack {
                
                SearchBar(text: $exploreViewModel.searchText)
                    .padding()

                
                ScrollView {
                    LazyVStack{
                        ForEach(exploreViewModel.searchableUsers) { user in
                            NavigationLink {
                                ProfileView(user: user)
                            } label: {
                                UserRowView(user: user)
                            }

                        }
                    }
                }
            }
            
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
//        }
        
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
