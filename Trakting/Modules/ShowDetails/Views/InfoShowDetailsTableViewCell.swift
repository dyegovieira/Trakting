//
//  InfoShowDetailsTableViewCell.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 28/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit
import TraktKit

final class InfoShowDetailsTableViewCell: UITableViewCell {
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        setupContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupContent() {
        selectionStyle = .none
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0
    }
    
    // MARK: - Method
    
    func reload(with object: TraktShow) {
        textLabel?.text = object.overview
        detailTextLabel?.text = "\n" + (object.genres?.joined(separator: ", ") ?? "")
    }
}
