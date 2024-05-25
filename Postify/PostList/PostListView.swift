//
//  PostListView.swift
//  Postify
//
//  Created by Nagaraj Rao on 25/05/24.
//

import SwiftUI

struct PostListView: View {
    @StateObject private var viewModel: PostViewModel
    @State private var showAlert = false
    @State private var errorMessage = ""
    
    init(viewModel: PostViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack { // Wrap ScrollView inside VStack
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.posts) { post in
                            NavigationLink(destination: PostDetailView(post: post)) {
                                PostRow(post: post)
                            }
                            .onAppear {
                                if post == viewModel.posts.last {
                                    viewModel.loadMorePosts()
                                }
                            }
                        }
                        if viewModel.isLoading {
                            ProgressView("Loading more...")
                                .padding()
                        }
                    }
                }
            }
            .navigationTitle("Posts")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")) {
                    showAlert = false // Dismiss the alert when "OK" is tapped
                })
            }
        }
        .onReceive(viewModel.$error) { error in
            guard let error = error else { return }
            errorMessage = error.message
            showAlert = true
        }
    }
}
