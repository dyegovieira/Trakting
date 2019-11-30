//
//  SignoutedWatchingTableViewCell.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 28/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit

protocol SignoutedWatchingTableViewCellDelegate: class {
    func didSelectLogSignIn(in cell: SignoutedWatchingTableViewCell)
}

final class SignoutedWatchingTableViewCell: UITableViewCell {
   
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
    
    private weak var delegate: SignoutedWatchingTableViewCellDelegate?
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
        label.text = "Find where to watch TV and discover what's hot."
        label.textAlignment = .center
        
        stackView.addArrangedSubview(label)
    }
    
    private func setupButton() {
        let button = UIButton(type: .roundedRect)
        button.setTitle("LOG/SIGN IN", for: .normal)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(logInAction), for: .touchUpInside)
        stackView.addArrangedSubview(button)
    }
    
    @objc private func logInAction() {
        delegate?.didSelectLogSignIn(in: self)
    }
    
      // MARK: - Methods
    
    func reload(delegate: SignoutedWatchingTableViewCellDelegate?) {
        self.delegate = delegate
    }
}
