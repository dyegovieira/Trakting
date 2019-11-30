//
//  ReachabilityHelper.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 30/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import Reachability

struct ReachabilityHelpr {
    static var hasConnection: Bool? {
        do {
            return try Reachability().connection != .unavailable
        } catch {
            return nil
        }
    }
}
