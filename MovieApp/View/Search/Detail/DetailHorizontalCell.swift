//
//  DetailHorizontalCell.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 09.08.23.
//

import UIKit
class DetailHorizontalCell: UICollectionViewCell {
    
    public static let identifier = "DetailHorizontalCell"
    let containerView = UIView()
    let horizontalController = SearchDetailHorizontalController()
    
    var didSelectHandler: ((Int) -> ())?
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.fillSuperview()
        
        containerView.addSubview(horizontalController.view)
        horizontalController.view.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 26, bottom: 0, right: 0))
        horizontalController.didSelectHandler = didSelectHandler
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

