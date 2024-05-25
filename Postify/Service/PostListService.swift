//
//  PostListService.swift
//  Postify
//
//  Created by Nagaraj Rao on 25/05/24.
//

import Combine

struct FetchPostsRequest: Request {
    let path = "/posts"
    var page: Int
    var queryParams: [String : String]? {
        ["_page": "\(page)", "_limit": "10"]
    }
    
    typealias ReturnType = [Post]
}

class PostService {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchPosts(page: Int) -> AnyPublisher<[Post], NetworkRequestError> {
        let request = FetchPostsRequest(page: page)
        return apiClient.dispatch(request)
    }
}
