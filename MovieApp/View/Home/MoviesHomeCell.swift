//
//  horizontalCell.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 12.07.23.
//

import UIKit

class MoviesHomeCell: UICollectionViewCell {
    
    public static let identifier = "MoviesHomeCell"
    let containerView = UIView()
    let horizontalController = MoviesGroupHorizontalController()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        horizontalController.view.constrainHeight(constant: 77)
        addSubview(containerView)
        containerView.fillSuperview()
        
        containerView.addSubview(horizontalController.view)
        horizontalController.view.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 26, bottom: 0, right: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
