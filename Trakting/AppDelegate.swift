//
//  AppDelegate.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 23/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var tabBarController: MainTabBarController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        tabBarController = MainTabBarController()
        MainRouter.setupModule(tabBarController)
        
        window = UIWindow()
        window?.tintColor = .systemRed
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        TraktKitHelper.validateURL(url) { success in
            guard success else { return }
            
            DispatchQueue.main.async {
                self.tabBarController?.reload(tab: .profile)
                self.tabBarController?.reload(tab: .watching)
                self.tabBarController?.presentedViewController?.dismiss(animated: true, completion: nil)
            }
        }
        
        return true
    }
}
