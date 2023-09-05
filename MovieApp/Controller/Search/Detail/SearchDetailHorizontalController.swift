//
//  SearchDetailHorizontalController.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 09.08.23.
//

import UIKit

class SearchDetailHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout{

    var didSelectHandler: ((Int) -> ())?
    
    var tabs: [String] = ["About", "Reviews", "Cast"]
    var selectedTab: String = "About"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(SearchDetailHorizontalCell.self, forCellWithReuseIdentifier: SearchDetailHorizontalCell.identifier)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchDetailHorizontalCell.identifier, for: indexPath) as! SearchDetailHorizontalCell
        
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
        let cell = collectionView.cellForItem(at: indexPath) as! SearchDetailHorizontalCell
        cell.selectorView.isHidden = true
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let string = tabs[indexPath.item] as NSString
        let width = string.size().width + 30
        
        return .init(width: width, height: 33)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 20, right: 0)
    }
}

