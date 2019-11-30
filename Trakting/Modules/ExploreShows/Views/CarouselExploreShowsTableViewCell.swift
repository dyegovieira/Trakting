//
//  CarouselExploreShowsTableViewCell.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit
import TraktKit

protocol CarouselExploreShowsTableViewCellDelegate: class {
    func didSelect(show object: ExploreShows.Item, in cell: CarouselExploreShowsTableViewCell)
}

final class CarouselExploreShowsTableViewCell: UITableViewCell {
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContent()
        setupTop()
        setupCollectionView()
        setupBottom()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Properties
    
    private weak var delegate: CarouselExploreShowsTableViewCellDelegate?
    private weak var stackView: UIStackView!
    private weak var collectionView: UICollectionView!
    private let itemSize = CGSize(width: 128.0, height: 172.0)
    private var objects: [ExploreShows.Item] = []
    
    // MARK: - Setup
    
    private func setupContent() {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 16.0
        
        self.stackView = stackView
        
        contentView.embed(view: stackView, anchors: [.top, .right, .left])
        contentView.bottomAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor).isActive = true
    }
    
    private func setupTop() {
        let view = UIView(frame: .zero)
        view.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        stackView.addArrangedSubview(view)
    }
    
    private func setupCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.itemSize = itemSize
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        collectionViewLayout.minimumInteritemSpacing = 16.0
        
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(PosterExploreShowsCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.collectionView = collectionView
        
        stackView.addArrangedSubview(collectionView)
        
        collectionView.heightAnchor.constraint(equalToConstant: itemSize.height).isActive = true
        collectionView.reloadData()
    }
    
    private func setupBottom() {
        let view = UIView(frame: .zero)
        view.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        stackView.addArrangedSubview(view)
    }
    
    // MARK: - Methods
    
    func reload(with objects: [ExploreShows.Item], delegate: CarouselExploreShowsTableViewCellDelegate?) {
        self.objects = objects
        self.delegate = delegate
        
        collectionView.reloadData()
        collectionView.setContentOffset(.zero, animated: false)
    }
}

// MARK: - UICollectionViewDataSource

extension CarouselExploreShowsTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
}

// MARK: - UICollectionViewDelegate

extension CarouselExploreShowsTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PosterExploreShowsCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.reload(with: objects[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut)
        animator.addAnimations {
            cell?.alpha = 0.5
        }
        animator.addCompletion({ step in
            if step == .end {
                cell?.alpha = 1.0
            }
        })
        animator.startAnimation()
        
        delegate?.didSelect(show: objects[indexPath.row], in: self)
    }
}
