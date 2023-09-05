//
//  Reviews.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 10.08.23.
//

import UIKit

struct Reviews: Decodable {
    let id: Int
    let results: [ReviewResult]
}

struct ReviewResult: Decodable {
    let author: String
    let content: String
    let author_details: AuthorDetail
    init(author: String, content: String, author_details: AuthorDetail) {
        self.author = author
        self.content = content
        self.author_details = author_details
    }
    
}

struct AuthorDetail: Decodable {
    let rating: Int?
    let avatar_path: String?
    
    init(rating: Int?, avatar_path: String?) {
        self.rating = rating
        self.avatar_path = avatar_path ?? ""
    }
}
