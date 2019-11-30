//
//  ExploreShowsPresenter.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit

final class ExploreShowsPresenter {

    // MARK: Properties

    weak var view: ExploreShowsView?
    var router: ExploreShowsWireframe?
    var interactor: ExploreShowsUseCase?
}

// MARK: - Presentation

extension ExploreShowsPresenter: ExploreShowsPresentation {
    func viewDidLoadAndSetup() {
        if let check = ReachabilityHelpr.hasConnection, check == false {
            interactor?.fetchCache()
            return
        }
        
        interactor?.fetchTrendingShows()
    }
    
    func viewDidSelectShow(_ object: ExploreShows.Item) {
        router?.showDetails(with: object)
    }
    
    func viewDidSearchFor(_ term: String) {
        interactor?.fetchShowByTerm(term)
    }
}

// MARK: - Interactor Output

extension ExploreShowsPresenter: ExploreShowsInteractorOutput {
    func didError(_ error: Error?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.showAlertError(error)
        }
    }
    
    func didFetchTShows(_ objects: [ExploreShows.Item], forSection section: ExploreShows.Section) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            switch section {
            case .trending:
                self.interactor?.fetchPopularShows()
            case .popular:
                self.interactor?.fetchWatchedShows()
            case .watched:
                self.interactor?.fetchCollectedShows()
            case .collected:
                self.interactor?.fetchAnticipatedShows()
            default:
                break
            }
            
            self.view?.reloadSection(section, with: objects)
        }
    }
    
    func didFetchSearchedShows(_ objects: [ExploreShows.Item]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.reloadSection(.searchResult, with: objects)
        }
    }
}
