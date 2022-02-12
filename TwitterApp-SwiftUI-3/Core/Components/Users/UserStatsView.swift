//
//  UserStatsView.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 07/02/2022.
//

import SwiftUI

struct UserStatsView: View {
    var body: some View {

        HStack(spacing: 24) {
            HStack {
                Text("807")
                    .font(.subheadline)
                    .bold()

                Text("Follwing")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            HStack {
                Text("20.9M")
                    .font(.subheadline)
                    .bold()

                Text("Follwers")
                    .font(.caption)
                    .foregroundColor(.gray)

            }
        }

    }
}

struct UserStatsView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatsView()
    }
}
