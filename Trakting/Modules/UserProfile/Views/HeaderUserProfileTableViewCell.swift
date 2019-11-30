//
//  HeaderUserProfileTableViewCell.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 27/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit
import TraktKit

final class HeaderUserProfileTableViewCell: UITableViewCell {
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContent()
        setupTop()
        setupBody()
        setupBottom()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Properties
    
    private weak var stackView: UIStackView!
    private weak var coverImageView: UIImageView!
    private weak var avatarImageView: UIImageView!
    private weak var nameLabel: UILabel!
    
    // MARK: - Setup
    
    private func setupContent() {
        let coverImageView = UIImageView(image: Placeholder.default)
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.alpha = 0.2
        contentView.embed(view: coverImageView)
        self.coverImageView = coverImageView
        
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.alignment = .center
        contentView.embed(view: stackView, anchors: [.top, .right, .left])
        contentView.bottomAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor).isActive = true
        self.stackView = stackView
    }
    
    private func setupTop() {
        let view = UIView(frame: .zero)
        view.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        stackView.addArrangedSubview(view)
    }
    
    private func setupBody() {
        let size: CGFloat = 64.0
        let avatarImageView = UIImageView(image: Placeholder.default)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.heightAnchor.constraint(equalToConstant: size).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: size).isActive = true
        avatarImageView.layer.cornerRadius = size * 0.5
        stackView.addArrangedSubview(avatarImageView)
        self.avatarImageView = avatarImageView
        
        let nameLabel = UILabel(frame: .zero)
        nameLabel.font = .boldSystemFont(ofSize: 24.0)
        nameLabel.numberOfLines = 2
        stackView.addArrangedSubview(nameLabel)
        self.nameLabel = nameLabel
    }
    
    private func setupBottom() {
        let view = UIView(frame: .zero)
        view.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        stackView.addArrangedSubview(view)
    }
    
    // MARK: - Methods
    
    func reload(with object: User?) {
        avatarImageView.setImage(with: "")
        coverImageView.setImage(with: "")
        nameLabel.text = object?.name ?? "---"
    }
}
