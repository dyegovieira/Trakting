//
//  UserProfileContract.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit

protocol UserProfileView: BaseViewController {
    func reloadAsSignouted()
    func reloadData(with object: User, infos: [UserProfile.Info])
}

protocol UserProfilePresentation: class {
    func viewDidLoadAndSetup()
    func viewDidSelectLogin()
    func viewDidSelectLogout()
}

protocol UserProfileUseCase: class {
    var isSignedIn: Bool { get }
    func fetchUserDetails()
    func logout()
}

protocol UserProfileInteractorOutput: class {
    func didError(_ error: Error?)
    func didFetchUserDetails(_ object: User)
    func didLogout()
}

protocol UserProfileWireframe: class {
    func showLogin(_ url: URL)
}
