//
//  SeasonEpisodesInteractor.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit

class SeasonEpisodesInteractor {
    
    // MARK: Properties
    
    weak var output: SeasonEpisodesInteractorOutput?
}

// MARK: - UserCase

extension SeasonEpisodesInteractor: SeasonEpisodesUseCase {
    func fetchEpisodes(with show: TraktShow, and season: TraktSeason) {
        TraktManager.sharedManager.getEpisodesForSeason(showID: show.ids.trakt, season: NSNumber(value: season.number), extended: [.Full]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let values):
                let results: [SeasonEpisodes.Result] = values.compactMap({
                    return SeasonEpisodes.Result(show: show, season: season, episode: $0)
                })
                self.output?.didFetchEpisodes(results)
            case .error(let error):
                self.output?.didError(error)
            }
        }
    }
    
    func fetchNextEpisodes(with show: TraktShow) {
        TraktManager.sharedManager.getNextEpisode(showID: show.ids.trakt, extended: [.Full]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                let result = SeasonEpisodes.Result(show: show, season: nil, episode: value)
                self.output?.didFetchNextEpisode(result)
            case .error(_):
                self.output?.didFetchNextEpisode(nil)
            }
        }
    }
    
    func markEpisodeAsWatched(_ episode: TraktEpisode, show: TraktShow) {
        let rawJSON: [String: Any] = [
            "ids": [
                "trakt": episode.ids.trakt,
            ]
        ]
        
        do {
            try TraktManager.sharedManager.addToHistory(movies: [], shows: [], episodes: [rawJSON]) { [weak self]  result in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.addToWatchlist(with: show)
                    self.output?.didMarkedAsWatched()
                case .fail:
                    self.output?.didError(SeasonEpisodes.Error.failedToMarkAsWatched)
                }
            }
        } catch {
            self.output?.didMarkedAsWatched()
        }
    }

    private func addToWatchlist(with object: TraktShow) {
        let rawJSON: [String: Any] = [
            "title": object.title,
            "year": object.year ?? 0,
            "id": [
                "trakt": object.ids.trakt,
            ]
        ]
        
        do {
            try TraktManager.sharedManager.addToWatchlist(movies: [], shows: [rawJSON], episodes: []) { _ in
                
            }
        } catch {
            
        }
    }
}
