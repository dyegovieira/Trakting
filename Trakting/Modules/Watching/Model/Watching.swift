//
//  Watching.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 26/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit

struct Watching {
    enum Section: Int {
        case empty, results, signouted
    }
    
    struct Result {
        var item: TraktListItem!
        var watched: TraktWatchedShow?
        
        var watchedCount: Int {
            guard let seasons = watched?.seasons else { return 0 }
            
            var watchedCount = 0
            
            for s in seasons {
                for e in s.episodes {
                    watchedCount += e.plays > 0 ? 1 : 0
                }
            }
            
            return watchedCount
        }
        
        var watchedPercentage: String {
            if let aired = watched?.show.airedEpisodes, aired > 0 {
                let perc = Float(watchedCount) / Float(max(watchedCount, aired)) * 100.0
                return String(format:"%3.0f%%", perc)
            }

            return "0%"
        }
    }
}
