//
//  EmptyWatchingTableViewCell.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 27/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit

protocol EmptyWatchingTableViewCellDelegate: class {
    func didSelectExploreShows(in cell: EmptyWatchingTableViewCell)
}

final class EmptyWatchingTableViewCell: UITableViewCell {
   
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContent()
        stackView.addArrangedSubview(Space.vertical(.zero))
        setupLabel()
        setupButton()
        stackView.addArrangedSubview(Space.vertical(.zero))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Properties
    
    private weak var delegate: EmptyWatchingTableViewCellDelegate?
    private weak var stackView: UIStackView!
        
    // MARK: - Setup

    private func setupContent() {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 32.0
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        self.stackView = stackView
        
        contentView.embed(view: stackView, anchors: [.top, .right, .left])
        contentView.bottomAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor).isActive = true
    }
    
    private func setupLabel() {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.text = "No TV Shows added to your watchlist yet."
        label.textAlignment = .center
        
        stackView.addArrangedSubview(label)
    }
    
    private func setupButton() {
        let button = UIButton(type: .roundedRect)
        button.setTitle("EXPLORE NOW", for: .normal)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(exploreAction), for: .touchUpInside)
        stackView.addArrangedSubview(button)
    }
    
    @objc private func exploreAction() {
        delegate?.didSelectExploreShows(in: self)
    }
    
      // MARK: - Methods
    
    func reload(delegate: EmptyWatchingTableViewCellDelegate?) {
        self.delegate = delegate
    }
}
