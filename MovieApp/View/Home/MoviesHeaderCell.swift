//
//  MoviesHeaderCell.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 11.07.23.
//

import UIKit

class MoviesHeaderCell: UICollectionViewCell {
   
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Movie")
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let numberLabel: UITextView = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.font = .boldSystemFont(ofSize: 96)
        textView.isScrollEnabled = false
        textView.textAlignment = .left
        textView.textColor = #colorLiteral(red: 0.001221513259, green: 0.5894046426, blue: 0.8993114233, alpha: 1)
        textView.backgroundColor = .clear
        textView.textContainerInset = .zero
        textView.contentInset = .zero
        textView.textContainer.lineFragmentPadding = .zero
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(numberLabel)
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        numberLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: -14, bottom: -40, right: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


