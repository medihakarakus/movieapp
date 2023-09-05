//
//  Cast.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 10.08.23.
//

import UIKit

struct Cast: Decodable {
    let id: Int
    let cast: [Credits]
    
}

struct Credits: Decodable {
    let name: String
    let profile_path: String?
    
}
