//
//  DummyViewController.swift
//  Bankey
//
//  Created by HanaTI on 2022/09/27.
//

import UIKit

class DummyViewController: UIViewController {
    
    let stackView = UIStackView()
    let titleLabel = UILabel()
    let logoutButton = UIButton(type: .system)
    
    weak var logoutDelegate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
}

extension DummyViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = "Welcome"
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.backgroundColor = .systemBlue
        logoutButton.tintColor = .white
        logoutButton.layer.cornerRadius = 5
        logoutButton.setTitle("LogOut", for: [])
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension DummyViewController {
    @objc func logoutTapped() {
        logoutDelegate?.didLogout()
    }
}
