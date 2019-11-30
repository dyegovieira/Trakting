//
//  WatchingPresenter.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit

final class WatchingPresenter {

    // MARK: Properties

    weak var view: WatchingView?
    var router: WatchingWireframe?
    var interactor: WatchingUseCase?
}

// MARK: - Presentation

extension WatchingPresenter: WatchingPresentation {
    func viewDidLoadAndSetup() {
        if interactor?.isSignedIn ?? false {
            interactor?.fetchWatchingShows(firstPage: true)
        } else {
            view?.reloadAsSignouted()
        }
    }

    func viewDidAskForMoreShows() {
        interactor?.fetchWatchingShows(firstPage: false)
    }
    
    func viewDidSelectExploreShows() {
        router?.showExploreShows()
    }
    
    func viewDidSelectLogin() {
        guard let oauthURL = TraktManager.sharedManager.oauthURL else { return }
        router?.showLogin(oauthURL)
    }
    
    func viewDidSelectShow(_ object: Watching.Result) {
        router?.showDetails(with: object)
    }
}

// MARK: - Interactor Output

extension WatchingPresenter: WatchingInteractorOutput {
    func didError(_ error: Error?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.showAlertError(error)
        }
    }
    
    func didFetchWatchingShows(_ objects: [Watching.Result]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.reloadSection(.results, with: objects)
        }
    }
}
