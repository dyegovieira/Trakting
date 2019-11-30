//
//  UIViewExtensions.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit

extension UIView {
  
    func embed(view: UIView, anchors: [UIRectEdge] = [.all]) {
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if anchors.contains(.top) || anchors.contains(.all) {
            view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        }
        
        if anchors.contains(.right) || anchors.contains(.all) {
            view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        }
        
        if anchors.contains(.bottom) || anchors.contains(.all) {
            view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
        
        if anchors.contains(.left) || anchors.contains(.all) {
            view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        }
    }
    
    func embedCentering(view: UIView) {
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
}
