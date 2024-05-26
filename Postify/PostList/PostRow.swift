//
//  PostRow.swift
//  Postify
//
//  Created by Nagaraj Rao on 25/05/24.
//

import SwiftUI

struct PostRow: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(post.title.removingNewlines())
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    
                    Text(post.body.removingNewlines())
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .lineLimit(2) // restrict to 2 lines
                        .multilineTextAlignment(.leading)
                }
                
                Image(systemName: Icon.chevronRight)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}
