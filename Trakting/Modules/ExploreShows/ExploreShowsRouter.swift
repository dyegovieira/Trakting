//
//  ExploreShowsRouter.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit
import TraktKit

final class ExploreShowsRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(_ viewController: ExploreShowsViewController) {
        let presenter = ExploreShowsPresenter()
        let router = ExploreShowsRouter()
        let interactor = ExploreShowsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter
    }
}

// MARK: - Wireframe

extension ExploreShowsRouter: ExploreShowsWireframe {
    func showDetails(with object: ExploreShows.Item) {
        let viewController = ShowDetailsViewController()
        ShowDetailsRouter.setupModule(viewController, show: object.show)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
}
