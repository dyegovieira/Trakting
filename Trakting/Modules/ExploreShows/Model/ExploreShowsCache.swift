//
//  ExploreShowsCache.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 30/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import Cachable

struct ExploreShowsCache: Codable, Cachable {
    static var defaultFileName = "ExploreShows"
    
    var sections: [ExploreShows.Section: [ExploreShows.Item]]
    
    var fileName: String {
        return ExploreShowsCache.defaultFileName
    }
}
