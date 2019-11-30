//
//  ExploreViewController.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit
import TraktKit

final class ExploreShowsViewController: BaseViewController {
    
    // MARK: - Properties
    
    var presenter: ExploreShowsPresentation?
    private weak var searchController: UISearchController!
    private weak var tableView: UITableView!
    private weak var refreshControl: UIRefreshControl!
    private var objects: [ExploreShows.Section: [ExploreShows.Item]] = [:]
    private var tableViewSections: [ExploreShows.Section] = []
    private var isSearching = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSearchController()
        setupTableView()
        presenter?.viewDidLoadAndSetup()
    }

    // MARK: - Setup
    
    private func setupView() {
        navigationItem.title = "Explore"
        view.backgroundColor = .black
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search TV Shows"
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        self.searchController = searchController
    }
    
    private func setupTableView() {
        tableViewSections = validSections()
        
        // Table View
        
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.register(CarouselExploreShowsTableViewCell.self)
        tableView.register(ResultExploreShowsTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
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
        tableViewSections = validSections()
        presenter?.viewDidLoadAndSetup()
    }
    
    private func setIsSearching(_ value: Bool) {
        tableView.allowsSelection = value
        isSearching = value
        tableViewSections = validSections()
        tableView.reloadData()
    }
    
    private func validSections() -> [ExploreShows.Section] {
        guard isSearching == false else {
            return [.searchResult]
        }
        
        var sections: [ExploreShows.Section] = []
        
        objects.forEach({ key, values in
            if values.isEmpty == false {
                sections.append(key)
            }
        })
        
        return sections.sorted(by: { $0.rawValue < $1.rawValue })
    }
}

// MARK: - ExploreShowsView

extension ExploreShowsViewController: ExploreShowsView {
    func reloadSection(_ section: ExploreShows.Section, with objects: [ExploreShows.Item]) {
        self.objects[section] = objects
        tableViewSections = validSections()
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension ExploreShowsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tableViewSection = tableViewSections[section]
        switch tableViewSection {
        case .searchResult: return objects[tableViewSection]?.count ?? 0
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableViewSection = tableViewSections[section]
        switch tableViewSection {
        case .searchResult: return nil
        default: return tableViewSection.details
        }
    }
}

// MARK: - UITableViewDelegate

extension ExploreShowsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewSection = tableViewSections[indexPath.section]
        
        switch tableViewSection {
        case .searchResult:
            let cell: ResultExploreShowsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            if let object = objects[tableViewSection]?[indexPath.row] {
                cell.reload(with: object)
            }
            return cell
            
        default:
            let cell: CarouselExploreShowsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            let shows = self.objects[tableViewSection] ?? []
            cell.reload(with: shows, delegate: self)
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
        let tableViewSection = tableViewSections[indexPath.section]
        
        switch tableViewSection {
        case .searchResult:
            if let object = objects[tableViewSection]?[indexPath.row] {
                presenter?.viewDidSelectShow(object)
            }
            
        default:
            break
        }
    }
}

// MARK: - ShowsCarouselTableViewCellDelegate

extension ExploreShowsViewController: CarouselExploreShowsTableViewCellDelegate {
    func didSelect(show object: ExploreShows.Item, in cell: CarouselExploreShowsTableViewCell) {
        presenter?.viewDidSelectShow(object)
    }
}

// MARK: - UISearchControllerDelegate

extension ExploreShowsViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        setIsSearching(true)
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        setIsSearching(false)
    }
}

// MARK: - UISearchBarDelegate

extension ExploreShowsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.viewDidSearchFor(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        setIsSearching(false)
    }
}
