//
//  SignoutedUserProfileTableViewCell.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 27/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit

protocol UserProfileSignoutedTableViewCellDelegate: class {
    func didSelectLogSignIn(in cell: SignoutedUserProfileTableViewCell)
}

final class SignoutedUserProfileTableViewCell: UITableViewCell {
   
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContent()
        setupTop()
        setupLabel()
        setupButton()
        setupBottom()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Properties
    
    private weak var delegate: UserProfileSignoutedTableViewCellDelegate?
    private weak var stackView: UIStackView!
        
    // MARK: - Private Methods

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
    
    private func setupTop() {
        let view = UIView(frame: .zero)
        view.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        stackView.addArrangedSubview(view)
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
    
    private func setupBottom() {
        let view = UIView(frame: .zero)
        view.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        stackView.addArrangedSubview(view)
    }
    
    @objc private func logInAction() {
        delegate?.didSelectLogSignIn(in: self)
    }
    
      // MARK: - Public Methods
    
    func reload(delegate: UserProfileSignoutedTableViewCellDelegate?) {
        self.delegate = delegate
    }
}
