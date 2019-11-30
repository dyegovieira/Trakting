//
//  UserProfileInteractor.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit

class UserProfileInteractor {

    // MARK: Properties

    weak var output: UserProfileInteractorOutput?
}

// MARK: - UserCase

extension UserProfileInteractor: UserProfileUseCase {
    var isSignedIn: Bool {
        return TraktManager.sharedManager.isSignedIn
    }
    
    func fetchUserDetails() {
        TraktManager.sharedManager.getUserProfile(username: "me", extended: [.Full, .Metadata]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.output?.didFetchUserDetails(value)
            case .error(let error):
                self.output?.didError(error)
            }
        }
    }
    
    func logout() {
        TraktManager.sharedManager.accessToken = nil
        self.output?.didLogout()
    }
}
