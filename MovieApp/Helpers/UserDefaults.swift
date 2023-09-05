//
//  UserDefaults.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 17.08.23.
//

import Foundation

extension UserDefaults {
    static let favoritedMovieKey = "favoritedMovieKey"
    
    func savedMovies() -> [MovieDetail] {
        guard let savedMovieData = UserDefaults.standard.value(forKey: UserDefaults.favoritedMovieKey) as? Data else { return [] }
        guard let savedMovies = NSKeyedUnarchiver.unarchiveObject(with: savedMovieData) as? [MovieDetail] else { return [] }
        return savedMovies
    }
    
    func deleteMovie(movie: MovieDetail) {
        let savedMovies = savedMovies()
        let filteredMovies = savedMovies.filter { (m) -> Bool in
            return m.title != movie.title
        }
        
        let data = NSKeyedArchiver.archivedData(withRootObject: filteredMovies)
        UserDefaults.standard.set(data, forKey: UserDefaults.favoritedMovieKey)
    }
    
}
