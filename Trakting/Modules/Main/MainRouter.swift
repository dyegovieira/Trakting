//
//  MainRouter.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit

final class MainRouter {
    
    // MARK: Properties
    
    weak var view: UITabBarController?

    // MARK: Static methods
    
    static func setupModule(_ tabBarController: MainTabBarController) {
        let presenter = MainPresenter()
        let router = MainRouter()
        let interactor = MainInteractor()
        
        tabBarController.tabsViewController = [
            .explore: setupExploreShows(),
            .watching: setupWatchingShows(),
            .profile: setupUseProfile()
        ]
        tabBarController.presenter =  presenter

        presenter.view = tabBarController
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = tabBarController
        
        interactor.output = presenter
    }
    
    // MARK: Private
    
    private static func setupExploreShows() -> BaseNavigationController {
        let viewController = ExploreShowsViewController()
        ExploreShowsRouter.setupModule(viewController)
        let navigationController = BaseNavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        let image = UIImage(named: "exploreTab")
        navigationController.tabBarItem = UITabBarItem(title: "Explore", image: image, tag: 0)
        return navigationController
    }
    
    private static func setupWatchingShows() -> BaseNavigationController {
        let viewController = WatchingViewController()
        WatchingRouter.setupModule(viewController)
        let navigationController = BaseNavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        let image = UIImage(named: "watchingTab")
        navigationController.tabBarItem = UITabBarItem(title: "Watching", image: image, tag: 0)
        return navigationController
    }
    
    private static func setupUseProfile() -> BaseNavigationController {
        let viewController = UserProfileViewController()
        UserProfileRouter.setupModule(viewController)
        let navigationController = BaseNavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        let image = UIImage(named: "profileTab")
        navigationController.tabBarItem = UITabBarItem(title: "Profile", image: image, tag: 0)
        return navigationController
    }
}

// MARK: - Wireframe

extension MainRouter: MainWireframe {
    
}
