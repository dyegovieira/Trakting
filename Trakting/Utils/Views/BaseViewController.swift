//
//  BaseViewController.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    open func rebuild() {
        
    }
    
    func showAlertError(_ error: Error?) {
        let alert = UIAlertController(title: "Trkting", message: error?.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Trkting", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
