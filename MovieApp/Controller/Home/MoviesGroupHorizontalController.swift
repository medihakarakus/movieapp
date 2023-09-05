//
//  HorizontalController.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 12.07.23.

import UIKit

class MoviesGroupHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout{

    let cellId = "cellId"

    var didSelectHandler: ((Int) -> ())?
    
    var tabs: [String] = ["Upcoming", "Top rated", "Popular", "Now playing"]
    var selectedTab: String = "Upcoming"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MoviesGroupHorizontalCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = #colorLiteral(red: 0.1353075504, green: 0.1656210124, blue: 0.1907449961, alpha: 1)

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MoviesGroupHorizontalCell
        cell.titleLabel.text = tabs[indexPath.item]
        cell.selectorView.isHidden = tabs[indexPath.item] != selectedTab
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTab = tabs[indexPath.item]
        collectionView.reloadData()
        didSelectHandler?(indexPath.item)
    }

    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MoviesGroupHorizontalCell
        cell.selectorView.isHidden = true
    }

    let lineSpacing: CGFloat = 12

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let string = tabs[indexPath.item] as NSString
        let width = string.size().width + 25
        
        return .init(width: width, height: 43)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 20, right: 0)
    }
}

