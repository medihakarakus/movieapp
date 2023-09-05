//
//  AboutMovieCell.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 09.08.23.
//

import UIKit
class AboutMovieCell: UICollectionViewCell {
    public static let identifier = "AboutMovieCell"
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.text = "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.  "
        label.numberOfLines = 0
        return label
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
