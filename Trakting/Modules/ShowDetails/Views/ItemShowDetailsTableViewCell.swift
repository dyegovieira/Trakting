//
//  ItemShowDetailsTableViewCell.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 28/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit
import TraktKit

final class ItemShowDetailsTableViewCell: UITableViewCell {
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        
        setupContent()
        stackView.addArrangedSubview(Space.horizontal(.double))
        setupPoster()
        stackView.addArrangedSubview(Space.horizontal(.double))
        setupLabels()
        stackView.addArrangedSubview(Space.horizontal(.double))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Properties
    
    private weak var stackView: UIStackView!
    private weak var titleLabel: UILabel!
    private weak var ratingLabel: UILabel!
    private weak var episodesLabel: UILabel!
    private weak var posterImageView: UIImageView!
    
    // MARK: - Setup
    
    private func setupContent() {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        stackView.alignment = .center
        
        self.stackView = stackView
        
        // base
        
        let mainStackView = UIStackView(frame: .zero)
        mainStackView.axis = .vertical
        mainStackView.addArrangedSubview(Space.vertical(.single))
        mainStackView.addArrangedSubview(stackView)
        mainStackView.addArrangedSubview(Space.vertical(.single))
        
        contentView.embed(view: mainStackView, anchors: [.top, .right, .left])
        contentView.bottomAnchor.constraint(greaterThanOrEqualTo: mainStackView.bottomAnchor).isActive = true
    }
  
    private func setupPoster() {
        let posterImageView = UIImageView(frame: .zero)
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 8.0
        posterImageView.clipsToBounds = true
        posterImageView.widthAnchor.constraint(equalToConstant: 64.0).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 86.0).isActive = true
        self.posterImageView = posterImageView
        
        stackView.addArrangedSubview(posterImageView)
    }
    
    private func setupLabels() {
        let mainStackView = UIStackView(frame: .zero)
        mainStackView.axis = .vertical
        mainStackView.spacing = 8.0
        stackView.addArrangedSubview(mainStackView)
        
        let titleLabel = UILabel(frame: .zero)
        titleLabel.font = .systemFont(ofSize: 16.0)
        self.titleLabel = titleLabel
        mainStackView.addArrangedSubview(titleLabel)
        
        let ratingLabel = UILabel(frame: .zero)
        ratingLabel.font = .systemFont(ofSize: 14)
        ratingLabel.textColor = .darkGray
        self.ratingLabel = ratingLabel
        mainStackView.addArrangedSubview(ratingLabel)
        
        let episodesLabel = UILabel(frame: .zero)
        episodesLabel.font = .systemFont(ofSize: 14)
        episodesLabel.textColor = .darkGray
        self.episodesLabel = episodesLabel
        mainStackView.addArrangedSubview(episodesLabel)
    }
    
    @objc private func exploreAction() {
        
    }
    
    // MARK: - Methods
    
    func reload(with show: TraktShow, season: TraktSeason) {
        posterImageView.setImage(kind: .poster, show: show, season: season, episode: nil)
        titleLabel.text = season.title
        let rating = String(format:"%3.0f%%", season.rating ?? 0.0)
        ratingLabel?.text = "🤍\(rating) (\(season.votes ?? 0) votes)"
        
        let airedEpisodes = season.airedEpisodes ?? 0
        let episodeCount = season.episodeCount ?? 0
        
        if airedEpisodes == episodeCount {
            episodesLabel.text = "\(episodeCount) episodes"
        } else {
            episodesLabel.text = "\(airedEpisodes) of \(episodeCount) episodes"
        }
    }
}
