//
//  UserProfile.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 27/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation

struct UserProfile {
    enum Section: Int {
        case header, info, signouted
    }
    
    struct Info {
        var label: String
        var value: String
    }
}
