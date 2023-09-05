//
//  Service.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 18.07.23.
//

import UIKit

class Service {
//    public static let url = "https://image.themoviedb.org/3"
    public static let image_url = "https://image.tmdb.org/t/p/original"
    
    static let shared = Service()
    public static let headers = [
      "accept": "application/json",
      "Authorization": "Bearer {Your token here}"
    ]
    
    func fetchGenres(completion: @escaping (MovieGenres?, Error?) -> ()) {
        let urlString = "https://api.themoviedb.org/3/genre/movie/list?language=en"
        fetchMovieGroup(urlString: urlString, completion: completion)
    }
    
    func fetchCredits(movieId: String, completion: @escaping (Cast?, Error?) -> ()) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/credits?language=en-US"
        fetchMovieGroup(urlString: urlString, completion: completion)
    }

    func fetchReviews(movieId: String, completion: @escaping (Reviews?, Error?) -> ()) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/reviews"
        fetchMovieGroup(urlString: urlString, completion: completion)
    }
    
    func fetchMovieDetail(movieId: String, completion: @escaping (_ details: MovieDetail?, Error?) -> ()) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)"
        fetchMovieGroup(urlString: urlString, completion: completion)
    }
    
    func fetchMovies(searchTerm: String, completion: @escaping (MovieGroup?, Error?) -> ()) {
        let queryItems = [
            URLQueryItem(name: "query", value: searchTerm),
            URLQueryItem(name: "api_key", value: "{Your api key here}")
        ]
        var urlComponents = URLComponents(string: "https://api.themoviedb.org/3/search/movie")!
        urlComponents.queryItems = queryItems
        fetchMovieGroup(urlString: urlComponents.string!, completion: completion)
    }
    
    func fetchNowPlaying(completion: @escaping (MovieGroup?, Error?) -> ()) {
        let urlString = "https://api.themoviedb.org/3/movie/now_playing"
        fetchMovieGroup(urlString: urlString, completion: completion)
    }
    
    func fetchUpcoming(completion: @escaping (MovieGroup?, Error?) -> ()) {
        let urlString = "https://api.themoviedb.org/3/movie/upcoming"
        fetchMovieGroup(urlString: urlString, completion: completion)
    }
    
    func fetchTopRated(completion: @escaping (MovieGroup?, Error?) -> ()) {
        let urlString = "https://api.themoviedb.org/3/movie/top_rated"
        fetchMovieGroup(urlString: urlString, completion: completion)
    }
    
    func fetchPopular(completion: @escaping (MovieGroup?, Error?) -> ()) {
        let urlString = "https://api.themoviedb.org/3/movie/popular"
        fetchMovieGroup(urlString: urlString, completion: completion)
    }
    
    fileprivate func fetchMovieGroup<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = Self.headers
        
        
        fetchJSONData(request, completion: completion)
    }
    
    fileprivate func fetchJSONData<T: Decodable>(_ request: NSMutableURLRequest, completion: @escaping (T?, Error?) -> ()) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest){ data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            do {
                if let data = data {
                    let objects = try JSONDecoder().decode(T.self, from: data)
                    completion(objects, nil)
                } else {
                    print("err")
                    completion(nil, nil)
                }
            } catch {
                print(error)
//                completion(nil, error)
            }
        }
        dataTask.resume()
    }
}
