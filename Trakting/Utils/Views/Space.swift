//
//  Space.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 28/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit

struct Space {
    
    enum Value: CGFloat {
        case zero = 0.0
        case min = 4.0
        case single = 8.0
        case double = 16.0
    }
    
    static func vertical(_ value: Value) -> UIView {
        let view = UIView(frame: .zero)
        view.heightAnchor.constraint(equalToConstant: value.rawValue).isActive = true
        return view
    }
    
    static func horizontal(_ value: Value) -> UIView {
        let view = UIView(frame: .zero)
        view.widthAnchor.constraint(equalToConstant: value.rawValue).isActive = true
        return view
    }
}
