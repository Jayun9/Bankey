//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by HanaTI on 2022/09/28.
//
import UIKit
import Foundation

class AccountSummaryViewController: UIViewController {
    
    let tableView = UITableView()
    
    var viewModel: AccountViewModel? = nil
    
    init(viewModel: AccountViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
    
}

extension AccountSummaryViewController {
    func setup() {
        setupTable()
        setupTableHeaderView()
        setupNavigationItem()
        viewModel?.fetchData()
    }
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseId)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
    }
    
    private func setupTableHeaderView() {
        let header = AccountSummaryHeaderView()

        header.frame.size.height = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height

        tableView.tableHeaderView = header
    }
    
    
    func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = appColor
    }
    
    func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func setupNavigationItem() {
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(tappedLogout))
        logoutButton.tintColor = .label

        navigationItem.rightBarButtonItem = logoutButton
    }
}

// MARK:- delegate
extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel, let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseId, for: indexPath) as? AccountSummaryCell else {
            return UITableViewCell()
        }
        let account = viewModel.getAccount(by: indexPath)
        cell.account = account
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }
}

// MARK: Action
extension AccountSummaryViewController {
    @objc func tappedLogout() {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}
