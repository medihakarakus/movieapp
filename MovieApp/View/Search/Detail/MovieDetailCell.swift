//
//  SearchDetailCell.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 09.08.23.
//

import UIKit

class MovieDetailCell: UICollectionViewCell {
    var movieDetail: MovieDetail? {
        didSet {
            
            if let profileImageUrl = movieDetail?.backdrop_path {
                let imageUrl = URL(string: Service.image_url + profileImageUrl)
                movieImageView.sd_setImage(with: imageUrl)
            } else {
                movieImageView.image = UIImage(named: "image 2")
            }
                
            nameLabel.text = movieDetail?.title
            ratingsLabel.text = movieDetail?.vote_average?.toMovieScore()
            yearLabel.text = movieDetail?.release_date?.toYear()
            
            if let runTime = movieDetail?.runtime {
                timeLabel.text =  String(runTime) + " Minutes"
            }
            
            if let posterUrl = movieDetail?.backdrop_path {
                let imageUrl = URL(string: Service.image_url + posterUrl)
                moviePosterView.sd_setImage(with: imageUrl)
            } else {
                moviePosterView.image = UIImage(named: "Rectangle 4")
            }
                                        
            categoryLabel.text = movieDetail?.genres?.first?.name
        }
    }
    
    public static let identifier = "MovieDetailCell"
    
    fileprivate let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let moviePosterView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.constrainHeight(constant: 120)
        iv.constrainWidth(constant: 95)
        return iv
    }()
    
    let starIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Star")?.withRenderingMode(.alwaysOriginal)
        icon.constrainHeight(constant: 16)
        icon.constrainWidth(constant: 16)
        return icon
    }()
    
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 0.529, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.attributedText = NSMutableAttributedString(string: "9.5", attributes: [NSAttributedString.Key.kern: 0.12])
        return label
    }()
    
    let ratingView: UIView = {
        let view = UIView()
        view.constrainWidth(constant: 54)
        view.constrainHeight(constant: 24)
        view.layer.backgroundColor =  UIColor(red: 0.145, green: 0.157, blue: 0.212, alpha: 0.32).cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.constrainHeight(constant: 48)
        label.constrainWidth(constant: 210)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        let attributedString = NSMutableAttributedString(string: "Spiderman No Way Home")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        return label
    }()
    
    let calendarIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "CalendarBlank")
        icon.constrainHeight(constant: 16)
        icon.constrainWidth(constant: 16)
        return icon
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "2019"
        label.textColor = UIColor(red: 0.573, green: 0.573, blue: 0.616, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let clockIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Clock")?.withRenderingMode(.alwaysOriginal)
        icon.constrainHeight(constant: 16)
        icon.constrainWidth(constant: 16)
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "139 Minutes"
        label.textColor = UIColor(red: 0.573, green: 0.573, blue: 0.616, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let ticketIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Ticket")
        icon.constrainHeight(constant: 16)
        icon.constrainWidth(constant: 16)
        return icon
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Action"
        label.textColor = UIColor(red: 0.573, green: 0.573, blue: 0.616, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let dividerLeftView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.412, green: 0.412, blue: 0.455, alpha: 1)
        view.constrainWidth(constant: 1)
        view.constrainHeight(constant: 16)
        return view
    }()
    let dividerRightView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.412, green: 0.412, blue: 0.455, alpha: 1)
        view.constrainWidth(constant: 1)
        view.constrainHeight(constant: 16)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(movieImageView)
        movieImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        addSubview(moviePosterView)
        moviePosterView.centerYAnchor.constraint(equalTo: movieImageView.bottomAnchor).isActive = true

        
        addSubview(ratingView)
        ratingView.anchor(top: nil, leading: nil, bottom: movieImageView.bottomAnchor, trailing: movieImageView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 6, right: 6))
        
        ratingView.addSubview(starIcon)
        starIcon.anchor(top: ratingView.topAnchor, leading: ratingView.leadingAnchor, bottom: ratingView.bottomAnchor, trailing: nil,padding: .init(top: 4, left: 8, bottom: 4, right: 0))
        ratingView.addSubview(ratingsLabel)
        ratingsLabel.anchor(top: ratingView.topAnchor, leading: starIcon.trailingAnchor, bottom: ratingView.bottomAnchor, trailing: ratingView.trailingAnchor,padding: .init(top: 4, left: 2, bottom: 4, right: 8))
        
        addSubview(nameLabel)
        nameLabel.anchor(top: movieImageView.bottomAnchor, leading: moviePosterView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        
        let yearStackView = UIStackView(arrangedSubviews: [calendarIcon, yearLabel])
        yearStackView.spacing = 3
        
        let timeStackView = UIStackView(arrangedSubviews: [clockIcon, timeLabel])
        timeStackView.spacing = 3
        
        let categoryStackView = UIStackView(arrangedSubviews: [ticketIcon, categoryLabel])
        categoryStackView.spacing = 3
        
        let descriptionStackView = UIStackView(arrangedSubviews: [
            yearStackView,
            dividerLeftView,
            timeStackView,
            dividerRightView,
            categoryStackView
        ])
        descriptionStackView.spacing = 12
        descriptionStackView.distribution = .equalSpacing
        descriptionStackView.alignment = .center
        addSubview(descriptionStackView)
        descriptionStackView.anchor(top: moviePosterView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 24, left: 50, bottom: 24, right: 50))
        
        moviePosterView.anchor(top: nil, leading: leadingAnchor, bottom: descriptionStackView.topAnchor, trailing: nil, padding: .init(top: 0, left: 29, bottom: 24, right: 0))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
