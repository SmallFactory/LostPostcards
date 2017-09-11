//
//  MainTabBarController.swift
//  LostPostcards
//
//  Created by Small Factory Studios on 9/9/17.
//  Copyright © 2017 Small Factory Studios. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginVC = LogInController()
                let navController = UINavigationController(rootViewController: loginVC)
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
        //HOME CONTROLLER
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected") , rootViewController: HomeController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //SEARCH CONTROLLER
        let searchNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //FAVORITE CONTROLLER
        let favoriteNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage:#imageLiteral(resourceName: "like_selected"))
        
        //USER PROFILE CONTROLLER
        let profileNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: ProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        tabBar.tintColor = .black
        
        viewControllers = [homeNavController,
                           searchNavController,
                           favoriteNavController,
                           profileNavController]
        
        //modify tabbar item insets
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    private func templateNavController(unselectedImage: UIImage,
                                       selectedImage: UIImage,
                                       rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        
        return navController
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.index(of: viewController)
        if index == 5 {
            return false
        }
//        if index == 2 {
//            let layout = UICollectionViewFlowLayout()
//            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
//            let navController = UINavigationController(rootViewController: photoSelectorController)
//            
//            present(navController, animated: true, completion: nil)
//            
//            return false
//        }
        return true
    }
}
