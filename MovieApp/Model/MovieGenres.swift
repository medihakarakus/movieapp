//
//  MovieGenres.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 29.08.23.
//

import UIKit

struct MovieGenres: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
