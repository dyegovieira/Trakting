//
//  ShowDetailsPresenter.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit

final class ShowDetailsPresenter {

    // MARK: Properties

    weak var view: ShowDetailsView?
    var router: ShowDetailsWireframe?
    var interactor: ShowDetailsUseCase?
    var show: TraktShow!
}

// MARK: - Presentation

extension ShowDetailsPresenter: ShowDetailsPresentation {
    func viewDidLoadAndSetup() {
        view?.reloadData(with: show)
        interactor?.fetchFullDetails(with: show)
    }
    
    func viewDidSelectAddToWatchlist() {
        interactor?.addToWatchlist(with: show)
    }
    
    func viewDidSelectSeason(_ object: TraktSeason) {
        router?.showSeasonEpisodes(with: show, season: object)
    }
}

// MARK: - Interactor Output

extension ShowDetailsPresenter: ShowDetailsInteractorOutput {
    func didFetchFullDetails(_ object: TraktShow) {
        self.interactor?.fetchSeasons(with: object)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.reloadFullData(with: object)
        }
    }
    
    func didFetchSeasons(_ object: [TraktSeason]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.reloadSeasons(with: object)
        }
    }
    
    func didError(_ error: Error?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.showAlertError(error)
        }
    }
    
    func didAddedToWatchlist() {
        
    }
    
    func didFailAddToWatchlist() {
        
    }
}
