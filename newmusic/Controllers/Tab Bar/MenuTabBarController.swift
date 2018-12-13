//
//  MenuTabBarController.swift
//  newmusic
//
//  Created by Joe Langenderfer on 12/10/18.
//  Copyright © 2018 Joe Langenderfer. All rights reserved.
//

import UIKit

class MenuTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
        
        //search
        let searchNavController = templateNavController(unselectedImage: UIImage(named: "searchColor")!, selectedImage: UIImage(named: "searchColor")!)
        //add
        let addNavController = templateNavController(unselectedImage: UIImage(named: "addColor")!, selectedImage: UIImage(named: "addColor")!)
        
        tabBar.tintColor = .black
        viewControllers = [searchNavController,
                           addNavController]
        
        //modify tab bar item insets
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }

}
