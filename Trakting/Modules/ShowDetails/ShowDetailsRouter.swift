//
//  ShowDetailsRouter.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit
import TraktKit

class ShowDetailsRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(_ viewController: ShowDetailsViewController, show: TraktShow) {
        let presenter = ShowDetailsPresenter()
        presenter.show = show
        
        let router = ShowDetailsRouter()
        let interactor = ShowDetailsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter
    }
}

// MARK: - Wireframe

extension ShowDetailsRouter: ShowDetailsWireframe {
    func showSeasonEpisodes(with show: TraktShow, season: TraktSeason) {
        let viewController = SeasonEpisodesViewController()
        SeasonEpisodesRouter.setupModule(viewController, show: show, season: season)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
}
