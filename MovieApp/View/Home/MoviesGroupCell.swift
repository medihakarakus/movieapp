//
//  HomeCell.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 06.07.23.
//

import UIKit

class MoviesGroupCell: UICollectionViewCell{

    public static let identifier = "MoviesGroupCell"
    let imageView = UIImageView(cornerRadius: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
