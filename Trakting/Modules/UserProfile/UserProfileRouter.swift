//
//  UserProfileRouter.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit
import SafariServices

class UserProfileRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(_ viewController: UserProfileViewController) {
        let presenter = UserProfilePresenter()
        let router = UserProfileRouter()
        let interactor = UserProfileInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter
    }
}

// MARK: - Wireframe

extension UserProfileRouter: UserProfileWireframe {
    func showLogin(_ url: URL) {
        let viewController = SFSafariViewController(url: url)
        
        if #available(iOS 13.0, *) {
            viewController.modalPresentationStyle = .automatic
        }
        
        view?.tabBarController?.present(viewController, animated: true, completion: nil)
    }
}
