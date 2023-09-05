//
//  MovieDetail.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 20.07.23.
//

import UIKit

class MovieDetail: NSObject, Encodable, Decodable, NSCoding {
    
    func encode(with coder: NSCoder) {
        coder.encode(backdrop_path ?? "", forKey: "backdrop_pathKey")
        coder.encode(title ?? "", forKey: "titleKey")
        coder.encode(overview ?? "", forKey: "overviewKey")
        coder.encode(poster_path ?? "", forKey: "poster_pathKey")
        coder.encode(release_date ?? "", forKey: "release_dateKey")
        coder.encode(runtime ?? "" , forKey: "runtimeKey")
        coder.encode(vote_average ?? 0, forKey: "vote_averageKey")
        coder.encode(genres ?? [], forKey: "genresKey")
    }
    required init?(coder: NSCoder) {
        self.backdrop_path = coder.decodeObject(forKey: "backdrop_pathKey") as? String
        self.title = coder.decodeObject(forKey: "titleKey") as? String
        self.overview = coder.decodeObject(forKey: "overviewKey") as? String
        self.poster_path = coder.decodeObject(forKey: "poster_pathKey") as? String
        self.release_date = coder.decodeObject(forKey: "release_dateKey") as? String
        self.runtime = coder.decodeObject(forKey: "runtimeKey") as? Int
        self.vote_average = coder.decodeObject(forKey: "vote_averageKey") as? Float
        self.genres = coder.decodeObject(forKey: "genresKey") as? [MovieCategory]
    }
    
    
    let backdrop_path: String?
    let title: String?
    let overview: String?
    let poster_path: String?
    let release_date: String?
    let runtime: Int?
    let vote_average: Float?
    let genres: [MovieCategory]?
}

class MovieCategory: NSObject, Encodable, Decodable, NSCoding {
    let id : Int?
    let name: String?
    
    func encode(with coder: NSCoder) {
        coder.encode(id ?? "", forKey: "id_pathKey")
        coder.encode(name ?? "", forKey: "nameKey")
    }
    required init?(coder: NSCoder) {
        self.id = coder.decodeObject(forKey: "id_pathKey") as? Int
        self.name = coder.decodeObject(forKey: "nameKey") as? String
    }
}
