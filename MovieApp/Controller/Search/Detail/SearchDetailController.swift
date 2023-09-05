//
//  SearchDetailController.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 09.08.23.
//

import UIKit

enum MovieDetailTab {
    case about
    case reviews
    case cast
}

class SearchDetailController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    var movieDetails: MovieDetail?
    var reviews = [ReviewResult]()
    var credits = [Credits]()
    var selectedTab: MovieDetailTab = .about
    
    fileprivate let movieId: String
    
    //dependency injection constructor
    init(movieId: String) {
        self.movieId = movieId
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
    }
    
    //MARK: setup Work
    
    func setupNavigationBarButtons() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = #colorLiteral(red: 0.1353075504, green: 0.1656210124, blue: 0.1907449961, alpha: 1)
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        let savedMovies = UserDefaults.standard.savedMovies()
        let hasFavorited = savedMovies.firstIndex(where: {$0.title == movieDetails?.title}) != nil
       
        if hasFavorited {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Vector")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Save"), style: .plain, target: self, action: #selector(handleSaveMovie))
        }
    }
    
    @objc func handleSaveMovie() {
        guard let movie = self.movieDetails else { return }
        
        var listOfMovies = UserDefaults.standard.savedMovies()
        listOfMovies.insert(movie, at: 0)
        
        let data = NSKeyedArchiver.archivedData(withRootObject: listOfMovies)
        UserDefaults.standard.set(data, forKey: UserDefaults.favoritedMovieKey)
        
        showBadgeHighlight()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Vector")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        
    }
    
    func showBadgeHighlight() {
        tabBarController?.viewControllers?[2].tabBarItem.badgeValue = "New"
    }
    
    func setupTableView() {
        collectionView.backgroundColor = #colorLiteral(red: 0.1353075504, green: 0.1656210124, blue: 0.1907449961, alpha: 1)
        
        collectionView.register(LoadingCell.self, forCellWithReuseIdentifier: LoadingCell.identifier)
        collectionView.register(MovieDetailCell.self, forCellWithReuseIdentifier: MovieDetailCell.identifier)
        collectionView.register(DetailHorizontalCell.self, forCellWithReuseIdentifier: DetailHorizontalCell.identifier)
        collectionView.register(AboutMovieCell.self, forCellWithReuseIdentifier: AboutMovieCell.identifier)
        collectionView.register(ReviewsCell.self, forCellWithReuseIdentifier: ReviewsCell.identifier)
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: CastCell.identifier)
        collectionView.contentInset = .init(top: 18, left: 0, bottom: 0, right: 0)
    }
    
    func fetchData() {
        Service.shared.fetchMovieDetail(movieId: movieId) { res, err in
            self.movieDetails = res
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.setupNavigationBarButtons()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        if movieDetails == nil {
            return 1
        }
        
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if movieDetails == nil {
            return 1
        }
        
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        }
        
        switch selectedTab {
        case .about:
            return 1
        case .reviews:
            return reviews.count
        case .cast:
            return credits.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieDetails else {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCell.identifier, for: indexPath) as! LoadingCell)
            cell.activityIndicator.startAnimating()
            return cell
        }
        
        if indexPath.section == 0 {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: MovieDetailCell.identifier, for: indexPath) as! MovieDetailCell)
            cell.movieDetail = movieDetails
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailHorizontalCell.identifier, for: indexPath) as! DetailHorizontalCell
            cell.horizontalController.didSelectHandler = { [weak self]  index in

                if index == 0 {
                    self?.selectedTab = .about
                } else if index == 1 {
                    self?.selectedTab = .reviews
                    self?.fetchReviews()
                } else {
                    self?.selectedTab = .cast
                    self?.fetchCredits()
                }
                    
                self?.collectionView.reloadSections([2])
            }
            return cell
        }
        
        switch selectedTab {
        case .about:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutMovieCell.identifier, for: indexPath) as! AboutMovieCell
            cell.descriptionLabel.text = movieDetails.overview
            return cell
        case .reviews:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewsCell.identifier, for: indexPath) as! ReviewsCell
            cell.reviews = reviews[indexPath.item]
            return cell
        case .cast:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.identifier, for: indexPath) as! CastCell
            cell.credits = credits[indexPath.item]
            return cell
        }
    }
    
    fileprivate func fetchReviews()  {
        Service.shared.fetchReviews(movieId: movieId) { res, err in
            self.reviews = res?.results ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    fileprivate func fetchCredits()  {
        Service.shared.fetchCredits(movieId: movieId) { res, err in
            self.credits = res?.cast ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if movieDetails == nil {
            return .init(width: view.frame.width, height: 100)
        }

        if indexPath.section == 0 {
            return .init(width: view.frame.width, height: 350)
        } else if indexPath.section == 1 {
            return .init(width: view.frame.width, height: 44)
        }
        
        switch selectedTab {
        case .about:
            return .init(width: view.frame.width - 2 * 29, height: 200)
        case .reviews:
            let width = view.frame.width - 34 - 24
            let frame = CGRect(x: 0, y: 0, width: width, height: 50)
            let reviewCell = ReviewsCell(frame: frame)
            reviewCell.reviews = reviews[indexPath.item]
            reviewCell.layoutIfNeeded()
            
            let targetSize = CGSize(width: width, height: 5000)
            let estimatedSize = reviewCell.systemLayoutSizeFitting(targetSize)
            let height = max(60, estimatedSize.height)
            return .init(width: width, height: height)
            
        case .cast:
            return .init(width: (view.frame.width - 29 - 65 - 41) / 2, height: 123)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if movieDetails == nil {
            return .zero
        }
        
        if section == 0 {
            return .init(top: 0, left: 0, bottom: 16, right: 0)
        } else if section == 1 {
            return .init(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            switch selectedTab {
            case .about:
                return .init(top: 24, left: 29, bottom: 0, right: 29)
            case .reviews:
                return .init(top: 18, left: 34, bottom: 16, right: 24)
            case .cast:
                return .init(top: 28, left: 29, bottom: 21, right: 41)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
}
