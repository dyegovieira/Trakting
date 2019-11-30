//
//  ExploreShows.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit

struct ExploreShows {
    struct Item: Codable {
        var show: TraktShow!
    }
    
    enum Section: Int, Codable {
        case trending, popular, watched, collected, anticipated, searchResult
        
        var details: String {
            switch self {
            case .trending: return "People watching right now!"
            case .popular: return "The most popular shows for all time."
            case .watched: return "The most watched TV shows for the last 7 days. Sorted by number of unique watchers."
            case .collected: return "The most collected TV shows for the last 7 days. Sorted by number of owners."
            case .anticipated: return "The most anticipated TV shows based on the number of lists a show appears on."
            default: return ""
            }
        }
    }
}
