//
//  UserProfileViewController.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 25/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import UIKit
import TraktKit

final class UserProfileViewController: BaseViewController {
    
    // MARK: - Properties
    
    var presenter: UserProfilePresentation?
    private var object: User?
    private weak var tableView: UITableView!
    private var tableViewSections: [UserProfile.Section] = []
    private var infos: [UserProfile.Info] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewDidLoadAndSetup()
    }
    
    override func rebuild() {
        presenter?.viewDidLoadAndSetup()
    }
    
    // MARK: Setup
    
    private func setupView() {
        view.backgroundColor = .black
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupTableView() {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.register(SignoutedUserProfileTableViewCell.self)
        tableView.register(HeaderUserProfileTableViewCell.self)
        tableView.register(InfoUserProfileTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        tableView.allowsSelection = false
        
        view.embed(view: tableView)
        
        self.tableView = tableView
    }
    
    // MARK: - Methods
    
    @objc private func logoutAction() {
        presenter?.viewDidSelectLogout()
    }
}

// MARK: - UserProfileView

extension UserProfileViewController: UserProfileView {
    func reloadAsSignouted() {
        self.object = nil
        self.infos = []
        tableViewSections = [.header, .signouted]
        tableView.reloadData()
        navigationItem.rightBarButtonItem = nil
    }
    
    func reloadData(with object: User, infos: [UserProfile.Info]) {
        self.object = object
        self.infos = infos
        tableViewSections = [.header, .info]
        
        let button = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutAction))
        navigationItem.rightBarButtonItem = button
        
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension UserProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tableViewSection = tableViewSections[section]
        switch tableViewSection {
        case .info: return infos.count
        default: return 1
        }
    }
}

// MARK: - UITableViewDelegate

extension UserProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewSection = tableViewSections[indexPath.section]
        
        switch tableViewSection {
        case .header:
            let cell: HeaderUserProfileTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.reload(with: object)
            return cell
            
        case .signouted:
            let cell: SignoutedUserProfileTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.reload(delegate: self)
            return cell
            
        default:
            let cell: InfoUserProfileTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.reload(with: infos[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
}

// MARK: - UserProfileSignoutedTableViewCellDelegate

extension UserProfileViewController: UserProfileSignoutedTableViewCellDelegate {
    func didSelectLogSignIn(in cell: SignoutedUserProfileTableViewCell) {
        presenter?.viewDidSelectLogin()
    }
}
