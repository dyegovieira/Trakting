//
//  ItemSeasonEpisodesTableViewCell.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 28/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit
import TraktKit

final class ItemSeasonEpisodesTableViewCell: UITableViewCell {
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .detailButton
        
        setupContent()
        mainStackView.addArrangedSubview(Space.vertical(.double))
        setupPosterAndLabels()
        setupOverview()
        mainStackView.addArrangedSubview(Space.vertical(.double))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Properties
    
    private weak var mainStackView: UIStackView!
    private weak var titleLabel: UILabel!
    private weak var ratingLabel: UILabel!
    private weak var overviewLabel: UILabel!
    private weak var pictureImageView: UIImageView!
    
    // MARK: - Setup
    
    private func setupContent() {
        let mainStackView = UIStackView(frame: .zero)
        mainStackView.axis = .vertical
        mainStackView.spacing = 8.0
        self.mainStackView = mainStackView
        
        contentView.embed(view: mainStackView, anchors: [.top, .right, .left])
        contentView.bottomAnchor.constraint(greaterThanOrEqualTo: mainStackView.bottomAnchor).isActive = true
    }
  
    private func setupPosterAndLabels() {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 8.0
        mainStackView.addArrangedSubview(stackView)
        stackView.addArrangedSubview(Space.horizontal(.single))
        
        let pictureImageView = UIImageView(frame: .zero)
        pictureImageView.contentMode = .scaleAspectFill
        pictureImageView.layer.cornerRadius = 8.0
        pictureImageView.clipsToBounds = true
        pictureImageView.widthAnchor.constraint(equalToConstant: 86.0).isActive = true
        pictureImageView.heightAnchor.constraint(equalToConstant: 64.0).isActive = true
        self.pictureImageView = pictureImageView
        stackView.addArrangedSubview(pictureImageView)
    
        // labels
        
        let labelStackView = UIStackView(frame: .zero)
        labelStackView.axis = .vertical
        labelStackView.spacing = 8.0
        
        let titleLabel = UILabel(frame: .zero)
        titleLabel.font = .systemFont(ofSize: 16.0)
        titleLabel.numberOfLines = 2
        self.titleLabel = titleLabel
        labelStackView.addArrangedSubview(titleLabel)
        
        let ratingLabel = UILabel(frame: .zero)
        ratingLabel.font = .systemFont(ofSize: 14)
        ratingLabel.textColor = .darkGray
        self.ratingLabel = ratingLabel
        labelStackView.addArrangedSubview(ratingLabel)
        
        stackView.addArrangedSubview(Space.horizontal(.single))
        stackView.addArrangedSubview(labelStackView)
        stackView.addArrangedSubview(Space.horizontal(.single))
    }
    
    private func setupOverview() {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        mainStackView.addArrangedSubview(stackView)
        
        stackView.addArrangedSubview(Space.horizontal(.single))
        
        let overviewLabel = UILabel(frame: .zero)
        overviewLabel.font = .systemFont(ofSize: 12)
        overviewLabel.textColor = .darkGray
        overviewLabel.numberOfLines = 0
        self.overviewLabel = overviewLabel
        stackView.addArrangedSubview(overviewLabel)
        
        stackView.addArrangedSubview(Space.horizontal(.single))
    }
    
    // MARK: - Methods
    
    func reload(with result: SeasonEpisodes.Result?) {
        let episode = result?.episode
        
        pictureImageView.setImage(kind: .backdrop, show: result?.show, season: result?.season, episode: result?.episode)
        titleLabel.text = episode?.title
        let rating = String(format:"%3.0f%%", episode?.rating ?? 0.0)
        ratingLabel?.text = "🤍\(rating) (\(episode?.votes ?? 0) votes)"
        overviewLabel.text = episode?.overview
    }
}
