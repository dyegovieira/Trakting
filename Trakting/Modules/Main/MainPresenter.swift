//
//  MainPresenter.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation

final class MainPresenter {

    // MARK: Properties

    weak var view: MainView?
    var router: MainWireframe?
    var interactor: MainUseCase?
}

// MARK: - Presentation

extension MainPresenter: MainPresentation {
    func viewDidLoadAndSetup() {
        
    }
    
    func viewDidAppear() {
        interactor?.setupAPI()
    }
}

// MARK: - Interactor Output

extension MainPresenter: MainInteractorOutput {
    func didSetupAPI() {
        view?.show(tabs: [
            .explore, .watching, .profile
        ])
    }
}
