//
//  AppDelegate.swift
//  LostPostcards
//
//  Created by Small Factory Studios on 9/8/17.
//  Copyright © 2017 Small Factory Studios. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = MainTabBarController()
        
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
}
