//
//  SeasonEpisodesContract.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit

protocol SeasonEpisodesView: BaseViewController {
    func reloadData(with title: String)
    func reloadEpisodes(with objects: [SeasonEpisodes.Result])
    func reloadNextEpisode(with object: SeasonEpisodes.Result?)
}

protocol SeasonEpisodesPresentation: class {
    func viewDidLoadAndSetup()
    func viewDidSelectMarkEpisodeAsWatched(with object: SeasonEpisodes.Result)
}

protocol SeasonEpisodesUseCase: class {
    func fetchEpisodes(with show: TraktShow, and season: TraktSeason)
    func fetchNextEpisodes(with show: TraktShow)
    func markEpisodeAsWatched(_ episode: TraktEpisode, show: TraktShow)
}

protocol SeasonEpisodesInteractorOutput: class {
    func didError(_ error: Error?)
    func didFetchEpisodes(_ object: [SeasonEpisodes.Result])
    func didFetchNextEpisode(_ object: SeasonEpisodes.Result?)
    func didMarkedAsWatched()
}

protocol SeasonEpisodesWireframe: class {
    
}
