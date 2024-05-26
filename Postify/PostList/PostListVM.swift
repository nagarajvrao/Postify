//
//  PostListVM.swift
//  Postify
//
//  Created by Nagaraj Rao on 25/05/24.
//

import SwiftUI
import Combine

final class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var error: NetworkRequestError? = nil
    
    private var currentPage = 1
    private var cancellables = Set<AnyCancellable>()
    private let postService: PostService
    
    init(postService: PostService) {
        self.postService = postService
        loadMorePosts()
    }
    
    func loadMorePosts() {
        guard !isLoading else { return }
        isLoading = true
        
        postService.fetchPosts(page: currentPage)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .map { posts in
                posts.map { post in
                    self.performIntensiveComputation(for: post)
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.isLoading = false
                case .failure(let error):
                    self?.error = error // Publish error
                    self?.isLoading = false
                }
            }, receiveValue: { [weak self] newPosts in
                self?.posts.append(contentsOf: newPosts)
                self?.currentPage += 1
            })
            .store(in: &cancellables)
    }
    
    private func performIntensiveComputation(for post: Post) -> Post {
        var computedPost = post
        
        let startTime = Date()
        // Simulate intensive computation
        let result = (1...1000).reduce(0) { $0 + $1 }
        computedPost.detailedInfo = Constants.computedValueForPost + "\(post.id ?? 0): \(result)"
        let endTime = Date()
        
        let computationTime = endTime.timeIntervalSince(startTime)
        print("Computation for post \(post.id ?? 0) took \(computationTime) seconds")
        
        return computedPost
    }
}
