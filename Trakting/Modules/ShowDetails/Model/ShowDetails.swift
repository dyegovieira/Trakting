//
//  ShowDetails.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 28/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation

struct ShowDetails {
    enum Section: Int {
        case info, seasons
    }
    
    struct Info {
        var label: String
        var value: String
    }
}
