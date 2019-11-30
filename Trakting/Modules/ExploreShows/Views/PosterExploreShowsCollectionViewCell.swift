//
//  PosterExploreShowsCollectionViewCell.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit
import TraktKit

final class PosterExploreShowsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    private weak var imageView: UIImageView!
    private var object: ExploreShows.Item!
    
    // MARK: - Setup
    
    private func setupLayout() {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        self.imageView = imageView
        
        let space = UIView(frame: .zero)
        space.heightAnchor.constraint(equalToConstant: 8.0).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [imageView, space])
        stackView.axis = .vertical
        stackView.spacing = 4.0
        
        contentView.embed(view: stackView, anchors: [.top, .right, .left])
        contentView.bottomAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor).isActive = true
        
        contentView.layer.cornerRadius = 5.0
        contentView.clipsToBounds = true
    }
    
    // MARK: - Methods
    
    func reload(with object: ExploreShows.Item) {
        self.object = object
        imageView.setImage(kind: .poster, show: object.show, season: nil, episode: nil)
    }
}
