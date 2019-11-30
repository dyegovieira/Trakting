//
//  MainContract.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation

protocol MainView: BaseTabBarController {
    func show(tabs: [Main.Tabs])
    func changeTo(tab: Main.Tabs)
    func reload(tab: Main.Tabs)
}

protocol MainPresentation: class {
    func viewDidLoadAndSetup()
    func viewDidAppear()
}

protocol MainUseCase: class {
    func setupAPI()
}

protocol MainInteractorOutput: class {
    func didSetupAPI()
}

protocol MainWireframe: class {
    
}
