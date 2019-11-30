//
//  TraktKitHelper.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 30/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit

struct TraktKitHelper {
    static func validateURL(_ url: URL?, _ completion: @escaping (Bool) -> Void) {
        guard let queryDict = url?.queryDict() else { return }
        guard url?.host == "auth" else { return }
        guard let code = queryDict["code"] as? String else { return }
        
        do {
            try TraktManager.sharedManager.getTokenFromAuthorizationCode(code: code) { result in
                switch result {
                case .success:
                    completion(true)
                case .fail:
                    completion(false)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
