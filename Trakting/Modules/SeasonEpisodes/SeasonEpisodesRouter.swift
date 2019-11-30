//
//  SeasonEpisodesRouter.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit
import TraktKit

class SeasonEpisodesRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(_ viewController: SeasonEpisodesViewController, show: TraktShow, season: TraktSeason) {
        let presenter = SeasonEpisodesPresenter()
        presenter.show = show
        presenter.season = season
        let router = SeasonEpisodesRouter()
        let interactor = SeasonEpisodesInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter
    }
}

// MARK: - Wireframe

extension SeasonEpisodesRouter: SeasonEpisodesWireframe {
    
}
