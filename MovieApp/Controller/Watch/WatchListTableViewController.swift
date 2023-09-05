//
//  WatchListTableViewController.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 24.08.23.
//

import UIKit

class WatchListTableViewController: UITableViewController {
    fileprivate let cellId = "cellId"
    var movies = UserDefaults.standard.savedMovies()
    
    let noResultView: UIView = {
        let view = UIView()
        view.constrainWidth(constant: 250)
        view.constrainHeight(constant: 200)
        return view
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "magic-box 1")
        image.constrainHeight(constant: 76)
        image.constrainWidth(constant: 76)
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.922, green: 0.922, blue: 0.938, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.31
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "There is no movie yet!", attributes: [NSAttributedString.Key.kern: 0.12, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor =  UIColor(red: 0.573, green: 0.573, blue: 0.616, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.31
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "Find your movie by Type title, categories, years, etc ", attributes: [NSAttributedString.Key.kern: 0.12, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    override func viewDidLoad() {
        setupTableView()
        setupNavController()
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.row]
        movies.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        UserDefaults.standard.deleteMovie(movie: movie)
        
        if movies.isEmpty {
            noResultView.isHidden = false
        }
        
    }
    
    func setupTableView() {
        tableView.register(WatchListCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = #colorLiteral(red: 0.1353075504, green: 0.1656210124, blue: 0.1907449961, alpha: 1)
        tableView.contentInset = .init(top: 16, left: 0, bottom: 0, right: 0)
        
        tableView.addSubview(noResultView)
        noResultView.centerXInSuperview()
        noResultView.anchor(top: tableView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 150, left: 0, bottom: 0, right: 0))
        
        
        noResultView.addSubview(imageView)
        imageView.anchor(top: noResultView.topAnchor, leading: nil, bottom: nil, trailing: nil)
        imageView.centerXInSuperview()
        
        noResultView.addSubview(titleLabel)
        titleLabel.anchor(top: imageView.bottomAnchor, leading: noResultView.leadingAnchor, bottom: nil, trailing: noResultView.trailingAnchor, padding: .init(top: 16, left: 40, bottom: 0, right: 40))
        
        noResultView.addSubview(descriptionLabel)
        
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        
    }
    
    fileprivate func setupNavController(){
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = #colorLiteral(red: 0.1353075504, green: 0.1656210124, blue: 0.1907449961, alpha: 1)
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Watch List"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        movies = UserDefaults.standard.savedMovies()
        tableView.reloadData()
        tabBarController?.viewControllers?[2].tabBarItem.badgeValue = nil
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movies.count > 0 {
            noResultView.isHidden = true
        }
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! WatchListCell
        cell.movieDetail = self.movies[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
    
}
