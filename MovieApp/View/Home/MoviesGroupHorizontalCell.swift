//
//  MoviesHomeCell.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 12.07.23.
//

import UIKit
class MoviesGroupHorizontalCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    let selectorView: UIView = {
        let view = UIView()
        view.constrainHeight(constant: 4)
        view.constrainWidth(constant: 90)
        view.layer.backgroundColor = UIColor(red: 0.227, green: 0.247, blue: 0.278, alpha: 1).cgColor
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(selectorView)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil)
        selectorView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

