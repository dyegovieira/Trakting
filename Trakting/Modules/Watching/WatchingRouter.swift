//
//  WatchingRouter.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit
import SafariServices
import TraktKit

class WatchingRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(_ viewController: WatchingViewController) {
        let presenter = WatchingPresenter()
        let router = WatchingRouter()
        let interactor = WatchingInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter
    }
}

// MARK: - Wireframe

extension WatchingRouter: WatchingWireframe {
    func showExploreShows() {
        (view?.tabBarController as? MainView)?.changeTo(tab: .explore)
    }
    
    func showLogin(_ url: URL) {
        let viewController = SFSafariViewController(url: url)
        
        if #available(iOS 13.0, *) {
            viewController.modalPresentationStyle = .automatic
        }
        
        view?.tabBarController?.present(viewController, animated: true, completion: nil)
    }
    
    func showDetails(with object: Watching.Result) {
        guard let show = object.item.show else { return }
        let viewController = ShowDetailsViewController()
        ShowDetailsRouter.setupModule(viewController, show: show)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
}
