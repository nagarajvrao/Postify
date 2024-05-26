//
//  PostDetailView.swift
//  Postify
//
//  Created by Nagaraj Rao on 25/05/24.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(post.title.unwrapped()) //Retaining newline character
                .font(.largeTitle)
                .padding(.bottom)
            Text(post.body.unwrapped()) //Retaining newline character
                .font(.body)
            if let detailedInfo = post.detailedInfo {
                Text(detailedInfo)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top)
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle(Constants.postDetails)
    }
}
