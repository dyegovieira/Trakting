//
//  NextEpisodeSeasonEpisodesTableViewCell.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 28/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit
import TraktKit

final class NextEpisodeSeasonEpisodesTableViewCell: UITableViewCell {
    
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
    }
    
    // MARK: - Method
    
    func reload(with object: SeasonEpisodes.Result?) {
        let episode = object?.episode
        textLabel?.text = episode?.title
        
        
        
        var detailText: String = ""
        
        if let overview = episode?.overview {
            detailText += "\n\(overview)\n"
        }
        
        if let firstAired = episode?.firstAired?.format(with: .full) {
            detailText += "\n\(firstAired)\n"
        }
        
        detailText += "season: \(episode?.season ?? 0), episode: \(episode?.number ?? 0)"
        
        detailTextLabel?.numberOfLines = 0
        detailTextLabel?.text = detailText
    }
}
