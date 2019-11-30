//
//  UserProfilePresenter.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import TraktKit
import DateToolsSwift

final class UserProfilePresenter {
    
    // MARK: Properties
    
    weak var view: UserProfileView?
    var router: UserProfileWireframe?
    var interactor: UserProfileUseCase?
}

// MARK: - Presentation

extension UserProfilePresenter: UserProfilePresentation {
    func viewDidLoadAndSetup() {
        if interactor?.isSignedIn ?? false {
            interactor?.fetchUserDetails()
        } else {
            view?.reloadAsSignouted()
        }
    }
    
    func viewDidSelectLogin() {
        guard let oauthURL = TraktManager.sharedManager.oauthURL else { return }
        router?.showLogin(oauthURL)
    }
    
    func viewDidSelectLogout() {
        interactor?.logout()
    }
}

// MARK: - Interactor Output

extension UserProfilePresenter: UserProfileInteractorOutput {
    func didError(_ error: Error?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.showAlertError(error)
        }
    }
    
    func didFetchUserDetails(_ object: User) {
        var infos: [UserProfile.Info] = []
        
        func boolTransformer(_ value: Bool?) -> String {
            return (value ?? false) ? "No" : "Yes"
        }
        
        func intTransfomer(_ value: Int?) -> String {
            if let value = value { return "\(value)" }
            return "---"
        }
        
        func dateTransform(_ value: Date?) -> String {
            return value?.timeAgoSinceNow ?? "---"
        }
        
        infos.append(UserProfile.Info(label: "Username", value: object.username ?? "---"))
        infos.append(UserProfile.Info(label: "Age", value: intTransfomer(object.age)))
        infos.append(UserProfile.Info(label: "Gender", value: object.gender ?? "---"))
        infos.append(UserProfile.Info(label: "Location", value: object.location ?? "---"))
        infos.append(UserProfile.Info(label: "Private", value: boolTransformer(object.isPrivate)))
        infos.append(UserProfile.Info(label: "VIP", value: boolTransformer(object.isVIP)))
        infos.append(UserProfile.Info(label: "VIPEP", value: boolTransformer(object.isVIPEP)))
        infos.append(UserProfile.Info(label: "Joined at", value: dateTransform(object.joinedAt)))
        infos.append(UserProfile.Info(label: "About", value: object.about ?? "---"))
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.reloadData(with: object, infos: infos)
        }
    }
    
    func didLogout() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.reloadAsSignouted()
        }
    }
}
