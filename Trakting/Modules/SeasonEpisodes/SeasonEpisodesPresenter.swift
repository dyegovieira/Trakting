//
//  SeasonEpisodesPresenter.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit

final class SeasonEpisodesPresenter {

    // MARK: Properties

    weak var view: SeasonEpisodesView?
    var router: SeasonEpisodesWireframe?
    var interactor: SeasonEpisodesUseCase?
    var show: TraktShow!
    var season: TraktSeason!
}

// MARK: - Presentation

extension SeasonEpisodesPresenter: SeasonEpisodesPresentation {
    func viewDidLoadAndSetup() {
        view?.reloadData(with: season.title ?? "---")
        interactor?.fetchNextEpisodes(with: show)
        interactor?.fetchEpisodes(with: show, and: season)
    }
    
    func viewDidSelectMarkEpisodeAsWatched(with object: SeasonEpisodes.Result) {
        guard let episode = object.episode else { return }
        
        let alert = UIAlertController(title: episode.title ?? "---", message: "Mark as watched?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.interactor?.markEpisodeAsWatched(episode, show: self.show)
        })
        alert.addAction(action)
        let cancelAction = UIAlertAction(title: "Not yet!", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        view?.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Interactor Output

extension SeasonEpisodesPresenter: SeasonEpisodesInteractorOutput {
    func didError(_ error: Error?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.showAlertError(error)
        }
    }
    
    func didFetchEpisodes(_ object: [SeasonEpisodes.Result]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.reloadEpisodes(with: object)
        }
    }
    
    func didFetchNextEpisode(_ object: SeasonEpisodes.Result?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.reloadNextEpisode(with: object)
        }
    }
    
    func didMarkedAsWatched() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.showAlert("Episode marked as watched!")
        }
    }
}
