//
//  WatchingContract.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit

protocol WatchingView: BaseViewController {
    func reloadAsSignouted()
    func reloadSection(_ section: Watching.Section, with objects: [Watching.Result])
}

protocol WatchingPresentation: class {
    func viewDidLoadAndSetup()
    func viewDidAskForMoreShows()
    func viewDidSelectExploreShows()
    func viewDidSelectLogin()
    func viewDidSelectShow(_ object: Watching.Result)
}

protocol WatchingUseCase: class {
    var isSignedIn: Bool { get }
    func fetchWatchingShows(firstPage: Bool)
}

protocol WatchingInteractorOutput: class {
    func didError(_ error: Error?)
    func didFetchWatchingShows(_ objects: [Watching.Result])
}

protocol WatchingWireframe: class {
    func showExploreShows()
    func showLogin(_ url: URL)
    func showDetails(with object: Watching.Result)
}
