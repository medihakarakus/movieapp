//
//  MoviesHomeController.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 06.07.23.
//

import UIKit
import SDWebImage

class MoviesHomeController: BaseListController, UICollectionViewDelegateFlowLayout {
    let headerId = "headerId"
    
    var movies: [MovieResult] = []
    var groups = [MovieGroup]()
    
    let titleView: UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = .boldSystemFont(ofSize: 22)
        view.text = "What do you want to watch?"
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        setupCollectionView()
        fetchMovieData()
    }
    
    func setupCollectionView() {
        view.addSubview(titleView)
        titleView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 24, bottom: 0, right: 0))
        
        collectionView.register(MoviesHomeCell.self, forCellWithReuseIdentifier: MoviesHomeCell.identifier)
        collectionView.register(MoviesGroupCell.self, forCellWithReuseIdentifier: MoviesGroupCell.identifier)
        collectionView.register(MoviesHomeHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: headerId)
        
        collectionView.backgroundColor = #colorLiteral(red: 0.1353075504, green: 0.1656210124, blue: 0.1907449961, alpha: 1)
        collectionView.contentInset = .init(top: 18, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView.reloadData()
    }
    
    fileprivate func fetchMovieData() {
        
        var group1: MovieGroup?
        var group2: MovieGroup?
        var group3: MovieGroup?
        var group4: MovieGroup?
        
        // help you sync your data fetches together
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchNowPlaying { movieGroup, error in
            print("Done with now playing movies")
            dispatchGroup.leave()
            group1 = movieGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchUpcoming { movieGroup, error in
            print("Done with now upcoming movies")
            dispatchGroup.leave()
            group2 = movieGroup
        }

        dispatchGroup.enter()
        Service.shared.fetchTopRated { movieGroup, error in
            print("Done with top rated movies")
            dispatchGroup.leave()
            group3 = movieGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchPopular { movieGroup, error in
            print("Done with popular movies")
            dispatchGroup.leave()
            group4 = movieGroup
        }
        
        //completion
        dispatchGroup.notify(queue: .main){
            print("completed your dispatch group tasks")
            
            if let group = group1{
                self.movies = group.results
                self.groups.append(group)
            }

            if let group = group2{
                self.groups.append(group)
            }

            if let group = group3 {
                self.groups.append(group)
            }

            if let group = group4 {
                self.groups.append(group)
            }
            
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! MoviesHomeHeader
            
            let topMovies = groups.last
            header.movieHeaderHorizontalController.topMovies = topMovies
            header.movieHeaderHorizontalController.collectionView.reloadData()
            
            return header
        }
     
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 0 {
            return .init(width: 831, height: 250)
        }
        
        return .zero
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return movies.count
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesHomeCell.identifier, for: indexPath) as! MoviesHomeCell
                        
            cell.horizontalController.didSelectHandler = { [weak self]  index in
                self?.movies = self?.groups[index].results ?? []
                self?.collectionView.reloadSections([1])
            }
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesGroupCell.identifier, for: indexPath) as! MoviesGroupCell
        let imageURL = Service.image_url + (movies[indexPath.item].poster_path ?? "")
        cell.imageView.sd_setImage(with: URL(string: imageURL))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return .init(width: view.frame.width, height: 60)
        }
        
        let width = Int(view.frame.width - 3 * 26) / 3
        let height = 145
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return .zero
        }
        
        return .init(top: 0 , left: 26, bottom: 10, right: 26)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return .zero
        }
        
        return 13
    }
}
