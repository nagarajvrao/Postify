//
//  Posts.swift
//  Postify
//
//  Created by Nagaraj Rao on 25/05/24.
//

import Foundation
struct Post: Codable, Identifiable, Equatable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
    
    var detailedInfo: String? = nil

}
