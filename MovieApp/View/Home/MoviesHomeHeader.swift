//
//  MoviesHomeHeaderCell.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 06.07.23.
//

import UIKit

class MoviesHomeHeader: UICollectionReusableView {
    
    let movieHeaderHorizontalController = MoviesHomeHeaderController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(movieHeaderHorizontalController.view)
        movieHeaderHorizontalController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
