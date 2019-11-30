//
//  SeasonEpisodes.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 28/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit

struct SeasonEpisodes {
    enum Section: Int {
        case nextEpisode, episodes
    }
    
    struct Result {
        var show: TraktShow?
        var season: TraktSeason?
        var episode: TraktEpisode?
    }
    
    enum Error: Swift.Error {
        case failedToMarkAsWatched
    }
}

extension SeasonEpisodes.Error: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .failedToMarkAsWatched:
            return "Failed to mark as watched."
        }
    }
}
