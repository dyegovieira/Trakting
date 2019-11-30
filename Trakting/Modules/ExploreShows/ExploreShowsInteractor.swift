//
//  ExploreShowsInteractor.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit
import Reachability
import Cachable

final class ExploreShowsInteractor {
    
    // MARK: Properties
    
    weak var output: ExploreShowsInteractorOutput?
    private var sections: [ExploreShows.Section: [ExploreShows.Item]] = [:]
    private let cacher: Cacher = Cacher(destination: .temporary)
    
    // MARK: Methods
    
    private func set(items: [ExploreShows.Item], section: ExploreShows.Section) {
        sections[section] = items
        
        let cachable = ExploreShowsCache(sections: sections)
        cacher.persist(item: cachable) { _, _ in }
    }
}

// MARK: - UserCase

extension ExploreShowsInteractor: ExploreShowsUseCase {
    func fetchCache() {
        guard let cached: ExploreShowsCache = cacher.load(fileName: ExploreShowsCache.defaultFileName) else {
            return
        }
        if let shows = cached.sections[.trending] {
            self.output?.didFetchTShows(shows, forSection: .trending)
        }
        
        if let shows = cached.sections[.popular] {
            self.output?.didFetchTShows(shows, forSection: .popular)
        }
        
        if let shows = cached.sections[.watched] {
            self.output?.didFetchTShows(shows, forSection: .watched)
        }
        
        if let shows = cached.sections[.collected] {
            self.output?.didFetchTShows(shows, forSection: .collected)
        }
        
        if let shows = cached.sections[.anticipated] {
            self.output?.didFetchTShows(shows, forSection: .anticipated)
        }
    }
    
    func fetchTrendingShows() {
        TraktManager.sharedManager.getTrendingShows() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let values, _, _):
                let items = values.compactMap({ return ExploreShows.Item(show: $0.show) })
                self.set(items: items, section: .trending)
                self.output?.didFetchTShows(items, forSection: .trending)
            case .error(let error):
                self.output?.didError(error)
            }
        }
    }
    
    func fetchPopularShows() {
        TraktManager.sharedManager.getPopularShows() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let values, _, _):
                let items = values.compactMap({ return ExploreShows.Item(show: $0) })
                self.set(items: items, section: .popular)
                self.output?.didFetchTShows(items, forSection: .popular)
            case .error(let error):
                self.output?.didError(error)
            }
        }
    }
    
    func fetchWatchedShows() {
        TraktManager.sharedManager.getWatchedShows(period: .Weekly) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let values, _, _):
                let items = values.compactMap({ return ExploreShows.Item(show: $0.show) })
                self.set(items: items, section: .watched)
                self.output?.didFetchTShows(items, forSection: .watched)
            case .error(let error):
                self.output?.didError(error)
            }
        }
    }
    
    func fetchCollectedShows() {
        TraktManager.sharedManager.getCollectedShows(period: .Weekly) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let values, _, _):
                let items = values.compactMap({ return ExploreShows.Item(show: $0.show) })
                self.set(items: items, section: .collected)
                self.output?.didFetchTShows(items, forSection: .collected)
            case .error(let error):
                self.output?.didError(error)
            }
        }
    }
    
    func fetchAnticipatedShows() {
        TraktManager.sharedManager.getAnticipatedShows() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let values, _, _):
                let items = values.compactMap({ return ExploreShows.Item(show: $0.show) })
                self.set(items: items, section: .anticipated)
                self.output?.didFetchTShows(items, forSection: .anticipated)
            case .error(let error):
                self.output?.didError(error)
            }
        }
    }
    
    func fetchShowByTerm(_ term: String) {
        TraktManager.sharedManager.search(query: term, types: [.show])  { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let values):
                let items = values.compactMap({ return ExploreShows.Item(show: $0.show) })
                self.output?.didFetchSearchedShows(items)
            case .error(let error):
                self.output?.didError(error)
            }
        }
    }
}
