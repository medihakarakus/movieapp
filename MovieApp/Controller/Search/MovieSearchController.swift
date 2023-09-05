//
//  MovieSearchController.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 19.07.23.
//

import UIKit

class MovieSearchController: BaseListController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate  {
    
    let cellId = "id123"
    var timer: Timer?
    fileprivate var movieResults = [MovieResult]()
    fileprivate var genres = [Genre]()
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    let noResultView: UIView = {
        let view = UIView()
        view.constrainWidth(constant: 250)
        view.constrainHeight(constant: 200)
        return view
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "no-results 1")
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
        label.attributedText = NSMutableAttributedString(string: "We are sorry, we can not find the movie :(", attributes: [NSAttributedString.Key.kern: 0.12, NSAttributedString.Key.paragraphStyle: paragraphStyle])
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
        super.viewDidLoad()
        setupCollectionView()
        setupNavController()
        setupSearchBar()
        fetchGenre()
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 0.1353075504, green: 0.1656210124, blue: 0.1907449961, alpha: 1)
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 6, left: 0, bottom: 0, right: 0)
        
        collectionView.addSubview(noResultView)
        noResultView.centerXInSuperview()
        noResultView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
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
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .white
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { (_) in
            Service.shared.fetchMovies(searchTerm: searchText) { res, err in
                self.movieResults = res?.results ?? []
                DispatchQueue.main.async {
                    self.noResultView.isHidden = !self.movieResults.isEmpty
                    self.collectionView.reloadData()
                }
            }
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieId = String(movieResults[indexPath.item].id)
        let detailController = SearchDetailController(movieId: movieId)
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    fileprivate func setupSearchBar()  {
        navigationItem.searchController = self.searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .lightGray
        searchController.searchBar.barStyle = .black
        searchController.searchBar.searchTextField.textColor = .white
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        cell.movieResult = movieResults[indexPath.item]
        let genreId = cell.movieResult.genre_ids.first
        
        for genre in genres where genreId == genre.id {
            cell.categoryLabel.text = genre.name
        }
        return cell
    }
    
    func fetchGenre() {
        Service.shared.fetchGenres(completion: { genre, err in
            self.genres = genre?.genres ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 120)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieResults.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        24
    }
    
}
