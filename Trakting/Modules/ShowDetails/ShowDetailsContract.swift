//
//  ShowDetailsContract.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit

protocol ShowDetailsView: BaseViewController {
    func reloadData(with object: TraktShow)
    func reloadFullData(with object: TraktShow)
    func reloadSeasons(with objects: [TraktSeason])
}

protocol ShowDetailsPresentation: class {
    func viewDidLoadAndSetup()
    func viewDidSelectAddToWatchlist()
    func viewDidSelectSeason(_ object: TraktSeason)
}

protocol ShowDetailsUseCase: class {
    func fetchFullDetails(with object: TraktShow)
    func fetchSeasons(with object: TraktShow)
    func addToWatchlist(with object: TraktShow)
}

protocol ShowDetailsInteractorOutput: class {
    func didError(_ error: Error?)
    func didFetchFullDetails(_ object: TraktShow)
    func didFetchSeasons(_ object: [TraktSeason])
    func didAddedToWatchlist()
    func didFailAddToWatchlist()
    
}

protocol ShowDetailsWireframe: class {
    func showSeasonEpisodes(with show: TraktShow, season: TraktSeason)
}
