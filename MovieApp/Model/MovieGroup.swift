//
//  MovieGroup.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 18.07.23.
//

import UIKit

struct MovieGroup: Decodable {
    let results: [MovieResult]
}

struct MovieResult: Decodable {
    let id: Int
    let poster_path : String?
    let title: String
    let vote_average: Float
    let release_date: String
    let genre_ids: [Int]
}







