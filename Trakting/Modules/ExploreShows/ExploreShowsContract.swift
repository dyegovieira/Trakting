//
//  ExploreShowsContract.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit

protocol ExploreShowsView: BaseViewController {
    func reloadSection(_ section: ExploreShows.Section, with objects: [ExploreShows.Item])
}

protocol ExploreShowsPresentation: class {
    func viewDidLoadAndSetup()
    func viewDidSelectShow(_ object: ExploreShows.Item)
    func viewDidSearchFor(_ term: String)
}

protocol ExploreShowsUseCase: class {
    func fetchCache()
    func fetchTrendingShows()
    func fetchPopularShows()
    func fetchWatchedShows()
    func fetchCollectedShows()
    func fetchAnticipatedShows()
    func fetchShowByTerm(_ term: String)
}

protocol ExploreShowsInteractorOutput: class {
    func didError(_ error: Error?)
    func didFetchTShows(_ objects: [ExploreShows.Item], forSection section: ExploreShows.Section)
    func didFetchSearchedShows(_ objects: [ExploreShows.Item])
}

protocol ExploreShowsWireframe: class {
    func showDetails(with object: ExploreShows.Item)
}
