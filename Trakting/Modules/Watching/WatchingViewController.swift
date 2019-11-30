//
//  WatchingViewController.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit
import TraktKit

final class WatchingViewController: BaseViewController {
    
    // MARK: - Properties
    
    var presenter: WatchingPresentation?
    private weak var searchController: UISearchController!
    private weak var tableView: UITableView!
    private weak var refreshControl: UIRefreshControl!
    private var objects: [Watching.Section: [Watching.Result]] = [:]
    private var tableViewSections: [Watching.Section] = []
    private var didSetup = false
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        didSetup = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewDidLoadAndSetup()
    }
    
    override func rebuild() {
        if didSetup {
            presenter?.viewDidLoadAndSetup()
        }
    }
    
    // MARK: - Setup
    
    private func setupView() {
        navigationItem.title = "Watching"
        view.backgroundColor = .black
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupTableView() {
        tableViewSections = []
        
        // Table View
        
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.register(SignoutedWatchingTableViewCell.self)
        tableView.register(EmptyWatchingTableViewCell.self)
        tableView.register(ResultWatchingTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
        view.embed(view: tableView)
        
        self.tableView = tableView
        
        // Refresh Control
        
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
        self.refreshControl = refreshControl
        tableView.refreshControl = refreshControl
    }
    
    // MARK: - Methods
    
    @objc private func refreshControlAction() {
        presenter?.viewDidLoadAndSetup()
    }
}

// MARK: - WatchingShowsView

extension WatchingViewController: WatchingView {
    func reloadAsSignouted() {
        tableViewSections = [.signouted]
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func reloadSection(_ section: Watching.Section, with objects: [Watching.Result]) {
        self.objects[section] = objects
        let hasItems = objects.isEmpty == false
        tableViewSections = hasItems ? [.results] : [.empty]
        tableView.allowsSelection = hasItems
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

// MARK: - UITableViewDataSource

extension WatchingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tableViewSection = tableViewSections[section]
        
        switch tableViewSection {
        case .results: return objects[tableViewSection]?.count ?? 0
        default: return 1
        }
    }
}

// MARK: - UITableViewDelegate

extension WatchingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewSection = tableViewSections[indexPath.section]
        
        switch tableViewSection {
        case .signouted:
            let cell: SignoutedWatchingTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.reload(delegate: self)
            return cell
            
        case .empty:
            let cell: EmptyWatchingTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.reload(delegate: self)
            return cell
            
        case .results:
            let cell: ResultWatchingTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            if let object = objects[tableViewSection]?[indexPath.row] {
                cell.reload(with: object)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewSection = tableViewSections[indexPath.section]
        return tableViewSection == .empty
            ? tableView.bounds.height * 0.5
            : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewSection = tableViewSections[indexPath.section]
        return tableViewSection == .empty
            ? tableView.bounds.height * 0.5 : 64.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tableViewSection = tableViewSections[indexPath.section]
        
        switch tableViewSection {
        case .results:
            if let object = objects[tableViewSection]?[indexPath.row] {
                presenter?.viewDidSelectShow(object)
            }
        default:
            break
        }
    }
}

// MARK: - WatchingShowsEmptyTableViewCellDelegate

extension WatchingViewController: EmptyWatchingTableViewCellDelegate {
    func didSelectExploreShows(in cell: EmptyWatchingTableViewCell) {
        presenter?.viewDidSelectExploreShows()
    }
}

// MARK: - WatchingShowsSignoutedTableViewCellDelegate

extension WatchingViewController: SignoutedWatchingTableViewCellDelegate {
    func didSelectLogSignIn(in cell: SignoutedWatchingTableViewCell) {
        presenter?.viewDidSelectLogin()
    }
}
