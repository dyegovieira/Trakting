//
//  MainInteractor.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit

final class MainInteractor {
    
    // MARK: Properties
    
    weak var output: MainInteractorOutput?
}

// MARK: - UserCase

extension MainInteractor: MainUseCase {
    func setupAPI() {
        TraktManager.sharedManager.set(
            clientID: TraktAPIConstants.clientId,
            clientSecret: TraktAPIConstants.clientSecret,
            redirectURI: TraktAPIConstants.redirectURI
        )
        
        output?.didSetupAPI()
    }
}
