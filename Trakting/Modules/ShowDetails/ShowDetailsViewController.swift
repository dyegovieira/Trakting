//
//  ShowDetailsController.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit
import TraktKit

final class ShowDetailsViewController: BaseViewController {
    
    // MARK: - Properties
    
    var presenter: ShowDetailsPresentation?
    private weak var tableView: UITableView!
    private var showObject: TraktShow!
    private var seasonsObjects: [TraktSeason] = []
    private var tableViewSections: [ShowDetails.Section] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        setupAddToWatchlistBarButton()
        presenter?.viewDidLoadAndSetup()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        navigationItem.title = "..."
        view.backgroundColor = .black
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupTableView() {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.register(InfoShowDetailsTableViewCell.self)
        tableView.register(ItemShowDetailsTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
        view.embed(view: tableView)
        
        self.tableView = tableView
    }
    
    private func setupAddToWatchlistBarButton() {
        let button = UIBarButtonItem(title: "Add to Watchlist", style: .plain, target: self, action: #selector(addToWatchlistAction))
        navigationItem.rightBarButtonItem = button
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc private func addToWatchlistAction() {
        let alert = UIAlertController(title: showObject.title, message: "Add show to watchlist?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.presenter?.viewDidSelectAddToWatchlist()
        })
        alert.addAction(action)
        let cancelAction = UIAlertAction(title: "Not yet!", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - ShowDetailsView

extension ShowDetailsViewController: ShowDetailsView {
    func reloadData(with object: TraktShow) {
        showObject = object
        tableViewSections = [.info]
        
        navigationItem.title = object.title
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        tableView.reloadData()
    }
    
    func reloadFullData(with object: TraktShow) {
        showObject = object
        tableViewSections = [.info]
        tableView.reloadData()
    }
    
    func reloadSeasons(with objects: [TraktSeason]) {
        seasonsObjects = objects
        tableViewSections = [.info, .seasons]
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension ShowDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tableViewSection = tableViewSections[section]
        switch tableViewSection {
        case .seasons: return seasonsObjects.count
        default: return 1
        }
    }
}

// MARK: - UITableViewDelegate

extension ShowDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewSection = tableViewSections[indexPath.section]
        
        switch tableViewSection {
        case .info:
            let cell: InfoShowDetailsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.reload(with: showObject)
            return cell
            
        case .seasons:
            let cell: ItemShowDetailsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.reload(with: showObject, season: seasonsObjects[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tableViewSection = tableViewSections[indexPath.section]
        
        switch tableViewSection {
        case .seasons:
            presenter?.viewDidSelectSeason(seasonsObjects[indexPath.row])
            
        default:
            break
        }
    }
}
