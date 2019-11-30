//
//  ResultWatchingTableViewCell.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 28/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit
import TraktKit

final class ResultWatchingTableViewCell: UITableViewCell {
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        
        setupContent()
        stackView.addArrangedSubview(Space.horizontal(.single))
        setupPoster()
        setupLabels()
        setupProgress()
        stackView.addArrangedSubview(Space.horizontal(.single))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Properties
    
    private weak var stackView: UIStackView!
    private weak var titleLabel: UILabel!
    private weak var subtitleLabel: UILabel!
    private weak var progressLabel: UILabel!
    private weak var progressSubLabel: UILabel!
    private weak var posterImageView: UIImageView!
    
    // MARK: - Setup
    
    private func setupContent() {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 16.0
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
        titleLabel.numberOfLines = 2
        titleLabel.font = .boldSystemFont(ofSize: 20.0)
        self.titleLabel = titleLabel
        mainStackView.addArrangedSubview(titleLabel)
        
        let subtitleLabel = UILabel(frame: .zero)
        subtitleLabel.numberOfLines = 1
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .lightGray
        subtitleLabel.numberOfLines = 2
        self.subtitleLabel = subtitleLabel
        mainStackView.addArrangedSubview(subtitleLabel)
    }
    
    func setupProgress() {
        let mainStackView = UIStackView(frame: .zero)
        mainStackView.axis = .vertical
        mainStackView.spacing = 2.0
        stackView.addArrangedSubview(mainStackView)
        
        let progressLabel = UILabel(frame: .zero)
        progressLabel.font = .boldSystemFont(ofSize: 30.0)
        progressLabel.textAlignment = .right
        self.progressLabel = progressLabel
        mainStackView.addArrangedSubview(progressLabel)
        
        let progressSubLabel = UILabel(frame: .zero)
        progressSubLabel.font = .italicSystemFont(ofSize: 11.0)
        progressSubLabel.textAlignment = .right
        self.progressSubLabel = progressSubLabel
        mainStackView.addArrangedSubview(progressSubLabel)
    }
    
    @objc private func exploreAction() {
        
    }
    
    // MARK: - Methods
    
    func reload(with object: Watching.Result) {
        let show = object.item.show
        
        titleLabel.text = show?.title
        posterImageView.setImage(kind: .poster, show: show, season: nil, episode: nil)
        
        let rating = String(format:"%3.0f%%", show?.rating ?? 0.0)
        subtitleLabel.text = "🤍\(rating) (\(show?.votes ?? 0) votes)"
        
        guard object.watched != nil else {
            progressLabel.text = nil
            progressSubLabel.text = nil
            return
        }
        
        progressLabel.text = object.watchedPercentage
        progressSubLabel.text = String(format: "%d of %d ", object.watchedCount, show?.airedEpisodes ?? 0)
    }
}
