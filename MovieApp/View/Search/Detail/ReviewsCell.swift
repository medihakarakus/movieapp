//
//  ReviewsCell.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 10.08.23.
//

import UIKit
class ReviewsCell: UICollectionViewCell {
    public static let identifier = "ReviewsCell"
    
    var reviews: ReviewResult? {
        didSet {
            if let profileImageUrl = reviews?.author_details.avatar_path {
                let imageUrl = URL(string: Service.image_url + profileImageUrl)
                profileImageView.sd_setImage(with: imageUrl)
            } else {
                profileImageView.image = UIImage(named: "Ellipse 1")
            }
            
            if let rating = reviews?.author_details.rating {
                ratingsLabel.text = String(describing: rating)
            } else {
                ratingsLabel.text = nil
            }
            
            nameLabel.text = reviews?.author
            descriptionLabel.text = reviews?.content
        }
    }
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Ellipse 1")
        iv.constrainHeight(constant: 44)
        iv.constrainWidth(constant: 44)
        iv.layer.cornerRadius = 22
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mediha"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.text = "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences"
        label.numberOfLines = 0
        return label
    }()
    
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.008, green: 0.588, blue: 0.898, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "9.5"
        label.textAlignment = .center
        return label
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let verticalStackView = VerticalStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil)
        addSubview(ratingsLabel)
        ratingsLabel.anchor(top: profileImageView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 14, left: 0, bottom: 0, right: 0))
        ratingsLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        addSubview(verticalStackView)
        verticalStackView.anchor(top: profileImageView.topAnchor, leading: profileImageView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


