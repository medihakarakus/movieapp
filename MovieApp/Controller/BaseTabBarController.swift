//
//  TabBarController.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 26.05.23.
//

import UIKit

class BaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        tabBar.isTranslucent = false
        tabBar.barTintColor = #colorLiteral(red: 0.140298456, green: 0.1654790044, blue: 0.1949313879, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0.140298456, green: 0.1654790044, blue: 0.1949313879, alpha: 1)
        
        viewControllers = [
            createViewController(viewController: MoviesHomeController(), title: "Home", imageName: "Home"),
            createViewController(viewController: MovieSearchController(), title: "Search", imageName: "Search"),
            createViewController(viewController: WatchListTableViewController(), title: "Watch List", imageName: "Save")
        ]
    }
    
    func createViewController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.tabBarItem.title = title
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
}
