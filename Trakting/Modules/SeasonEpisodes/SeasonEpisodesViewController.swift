//
//  SeasonEpisodesController.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit

final class SeasonEpisodesViewController: BaseViewController {
    
    // MARK: - Properties
    
    var presenter: SeasonEpisodesPresentation?
    private weak var tableView: UITableView!
    private var tableViewSections: [SeasonEpisodes.Section] = []
    private var sectionRows: [SeasonEpisodes.Section: [SeasonEpisodes.Result]] = [:]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
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
        tableViewSections = [.nextEpisode, .episodes]
        sectionRows[.nextEpisode] = []
        sectionRows[.episodes] = []
        
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.register(NextEpisodeSeasonEpisodesTableViewCell.self)
        tableView.register(ItemSeasonEpisodesTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
        view.embed(view: tableView)
        
        self.tableView = tableView
    }
}

// MARK: - SeasonEpisodesView

extension SeasonEpisodesViewController: SeasonEpisodesView {
    
    func reloadData(with title: String) {
        navigationItem.title = title
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func reloadEpisodes(with objects: [SeasonEpisodes.Result]) {
        sectionRows[.episodes] = objects
        tableView.reloadData()
    }
    
    func reloadNextEpisode(with object: SeasonEpisodes.Result?) {
        if let object = object {
            sectionRows[.nextEpisode] = [object]
        } else {
            sectionRows[.nextEpisode] = []
        }
        
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension SeasonEpisodesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tableViewSection = tableViewSections[section]
        return sectionRows[tableViewSection]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableViewSection = tableViewSections[section]
        let count = sectionRows[tableViewSection]?.count ?? 0
        
        switch tableViewSection {
        case .nextEpisode:
            return count > 0 ? "Next episode" : nil
            
        case .episodes:
            return "Episodes"
        }
    }
}

// MARK: - UITableViewDelegate

extension SeasonEpisodesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewSection = tableViewSections[indexPath.section]
        let result = sectionRows[tableViewSection]?[indexPath.row]
        
        switch tableViewSection {
        case .nextEpisode:
            let cell: NextEpisodeSeasonEpisodesTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.reload(with: result)
            return cell
            
        case .episodes:
            let cell: ItemSeasonEpisodesTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.reload(with: result)
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
        guard tableViewSection == .episodes else { return }
        guard let result = sectionRows[tableViewSection]?[indexPath.row] else { return }
        self.presenter?.viewDidSelectMarkEpisodeAsWatched(with: result)
    }
}
