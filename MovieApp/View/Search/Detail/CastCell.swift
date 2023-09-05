//
//  CastCell.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 10.08.23.
//

import UIKit
class CastCell: UICollectionViewCell {
    var credits: Credits? {
        didSet {
            if let profileImageUrl = credits?.profile_path {
                let imageUrl = URL(string: Service.image_url + profileImageUrl)
                profileImageView.sd_setImage(with: imageUrl)
            } else {
                profileImageView.image = UIImage(named: "Ellipse 1")
            }
            
            nameLabel.text = credits?.name
        }
    }
    
    public static let identifier = "CastCell"
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Ellipse 1")
        iv.constrainHeight(constant: 100)
        iv.constrainWidth(constant: 100)
        iv.layer.cornerRadius = 50
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Tom Holland"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        profileImageView.centerXInSuperview()
        addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, leading: profileImageView.leadingAnchor, bottom: nil, trailing: profileImageView.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


