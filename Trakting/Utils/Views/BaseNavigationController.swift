//
//  BaseNavigationController.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 28/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    func rebuildRootViewController() {
        (viewControllers.first as? BaseViewController)?.rebuild()
    }
}
