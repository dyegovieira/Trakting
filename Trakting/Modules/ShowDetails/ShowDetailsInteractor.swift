//
//  ShowDetailsInteractor.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit

class ShowDetailsInteractor {
    
    // MARK: Properties
    
    weak var output: ShowDetailsInteractorOutput?
}

// MARK: - UserCase

extension ShowDetailsInteractor: ShowDetailsUseCase {
    func fetchFullDetails(with object: TraktShow) {
        TraktManager.sharedManager.getShowSummary(showID: object.ids.trakt, extended: [.Full, .Episodes]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.output?.didFetchFullDetails(value)
            case .error(let error):
                self.output?.didError(error)
            }
        }
    }
    
    func fetchSeasons(with object: TraktShow) {
        TraktManager.sharedManager.getSeasons(showID: object.ids.trakt, extended: [.Full]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let values):
                self.output?.didFetchSeasons(values)
            case .error(let error):
                self.output?.didError(error)
            }
        }
    }
    
    func addToWatchlist(with object: TraktShow) {
        let rawJSON: [String: Any] = [
            "title": object.title,
            "year": object.year ?? 0,
            "id": [
                "trakt": object.ids.trakt,
            ]
        ]
        
        do {
            try TraktManager.sharedManager.addToWatchlist(movies: [], shows: [rawJSON], episodes: []) { [weak self]  result in
                guard let self = self else { return }
                switch result {
                case .success:
                    print("success added")
                    self.output?.didAddedToWatchlist()
                case .fail:
                    print("fail added")
                    self.output?.didFailAddToWatchlist()
                }
            }
        } catch {
            self.output?.didFailAddToWatchlist()
        }
    }
}
