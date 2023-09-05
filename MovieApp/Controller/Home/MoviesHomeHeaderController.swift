//
//  MoviesHomeHeaderController.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 11.07.23.
//

import UIKit

class MoviesHomeHeaderController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "123"
    var topMovies: MovieGroup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MoviesHeaderCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.backgroundColor =  #colorLiteral(red: 0.1353075504, green: 0.1656210124, blue: 0.1907449961, alpha: 1)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 0, left: 14, bottom: 18, right: 0)
    }
    
        
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        topMovies?.results.prefix(5).count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MoviesHeaderCell
        
        let movie = topMovies?.results[indexPath.item]
        let imageURL = Service.image_url + (movie?.poster_path ?? "")
        cell.imageView.sd_setImage(with: URL(string: imageURL))
        
        cell.numberLabel.text = "\(indexPath.item + 1)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 140, height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 7, left: 14, bottom: 0, right: 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
}

