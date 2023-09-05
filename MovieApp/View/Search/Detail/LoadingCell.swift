//
//  AboutMovieCell.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 09.08.23.
//

import UIKit
class LoadingCell: UICollectionViewCell {
    public static let identifier = "LoadingCell"
    
    let activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(activityIndicator)
        activityIndicator.constrainWidth(constant: 20)
        activityIndicator.constrainHeight(constant: 20)
        activityIndicator.centerInSuperview()
        activityIndicator.startAnimating()
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
