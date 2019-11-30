//
//  URLExtension.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 27/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation

extension URL {
    func queryDict() -> [String: Any] {
        var info: [String: Any] = [:]
        
        guard let queryString = query else {
            return info
        }
        
        for parameter in queryString.components(separatedBy: "&") {
            let parts = parameter.components(separatedBy: "=")
            
            if parts.count > 1 {
                let key = parts[0].removingPercentEncoding
                let value = parts[1].removingPercentEncoding
                
                if let key = key, let value = value {
                    info[key] = value
                }
            }
        }
        
        return info
    }
}
