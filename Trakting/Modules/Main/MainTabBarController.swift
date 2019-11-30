//
//  MainTabBarController.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit

final class MainTabBarController: BaseTabBarController {
    
    // MARK: - Properties
    
    var presenter: MainPresentation?
    var tabsViewController: [Main.Tabs: BaseNavigationController] = [:]
    private var displaiedTabs: [Main.Tabs] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.viewDidAppear()
    }

}

// MARK: - MainView

extension MainTabBarController: MainView {
    func show(tabs: [Main.Tabs]) {
        var vcs: [UIViewController] = []
        displaiedTabs = []
        
        for tab in tabs {
            displaiedTabs.append(tab)
            if let vc = tabsViewController[tab] {
                vcs.append(vc)
            }
        }
        
        setViewControllers(vcs, animated: true)
    }
    
    func changeTo(tab: Main.Tabs) {
        guard let index = displaiedTabs.firstIndex(where: { $0.rawValue == tab.rawValue }) else {
            return
        }
        
        selectedIndex = index
    }
    
    func reload(tab: Main.Tabs) {
        let navigationController = tabsViewController[tab]
        navigationController?.popToRootViewController(animated: false)
        navigationController?.rebuildRootViewController()
    }
}
