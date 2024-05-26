//
//  PostifyApp.swift
//  Postify
//
//  Created by Nagaraj Rao on 25/05/24.
//

import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            let networkDispatcher = NetworkDispatcher()
            let apiClient = APIClient(baseURL: Constants.baseURL, networkDispatcher: networkDispatcher)
            let postService = PostService(apiClient: apiClient)
            let viewModel = PostViewModel(postService: postService)
            
            PostListView(viewModel: viewModel)
        }
    }
}
