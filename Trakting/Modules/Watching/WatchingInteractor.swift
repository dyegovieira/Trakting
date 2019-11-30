//
//  WatchingInteractor.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit

final class WatchingInteractor {
    
    // MARK: Properties
    
    weak var output: WatchingInteractorOutput?
}

// MARK: - UserCase

extension WatchingInteractor: WatchingUseCase {
    var isSignedIn: Bool {
        return TraktManager.sharedManager.isSignedIn
    }
    
    func fetchWatchingShows(firstPage: Bool) {
        var results: [Watching.Result] = []
        
        TraktManager.sharedManager.getWatchlist(watchType: .Shows, extended: [.Episodes, .Full]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items, _, _):
                results = items.compactMap({ return Watching.Result(item: $0, watched: nil) })
                
                TraktManager.sharedManager.getWatchedShows(extended: [.Episodes, .Full]) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let watcheds):
                        for watched in watcheds {
                            if let index = results.firstIndex(where: {
                                $0.item.show?.ids.trakt == watched.show.ids.trakt
                            }) {
                                results[index].watched = watched
                            }
                        }

                    case .error(let error):
                        self.output?.didError(error)
                    }
                    
                    self.output?.didFetchWatchingShows(results)
                }
                
            case .error(let error):
                self.output?.didError(error)
            }
        }
        
        
    }
}
