//
//  WatchListCell.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 24.08.23.
//

import UIKit

class WatchListCell: UITableViewCell {
    var movieDetail: MovieDetail! {
        didSet {
            let imageUrl = URL(string: Service.image_url + (movieDetail.poster_path ?? ""))
            movieImageView.sd_setImage(with: imageUrl)
            nameLabel.text = movieDetail.title
            ratingsLabel.text = movieDetail.vote_average?.toMovieScore()
            yearLabel.text = movieDetail.release_date?.toYear()
            categoryLabel.text = movieDetail.genres?.first?.name
            
            if let runTime = movieDetail?.runtime {
                timeLabel.text =  String(runTime) + " Minutes"
            }
        }
    }

    let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Movie")
        iv.widthAnchor.constraint(equalToConstant: 95).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 120).isActive = true
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Movie Name"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let starIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Star")
        icon.constrainHeight(constant: 16)
        icon.constrainWidth(constant: 16)
        return icon
    }()
    
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 0.529, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        label.attributedText = NSMutableAttributedString(string: "9.5", attributes: [NSAttributedString.Key.kern: 0.12])
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
        label.textColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
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
        label.textColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
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
        label.text = "139 minutes"
        label.textColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    func setupUI() {
        backgroundColor = #colorLiteral(red: 0.1353075504, green: 0.1656210124, blue: 0.1907449961, alpha: 1)
        addSubview(movieImageView)
        
        movieImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        

        let iconVerticalStackView = UIStackView(arrangedSubviews: [
            VerticalStackView(arrangedSubviews: [starIcon, ticketIcon, calendarIcon, clockIcon ], spacing: 6),
            VerticalStackView(arrangedSubviews: [ratingsLabel, nameLabel, categoryLabel, yearLabel, timeLabel], spacing: 4)
        ])
        
        iconVerticalStackView.spacing = 4
        
        let infoTopStackView = VerticalStackView(arrangedSubviews: [nameLabel, iconVerticalStackView])
        
        infoTopStackView.spacing = 14
        
        addSubview(infoTopStackView)
        
        infoTopStackView.anchor(top: topAnchor, leading: movieImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 39))

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
