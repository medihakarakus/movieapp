//
//  HorizontalSnappingController.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 06.07.23.
//

import UIKit

class HorizontalSnappingController: UICollectionViewController {
    init() {
        let layout = BetterSnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
//        collectionView.decelerationRate = .fast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

