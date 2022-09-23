//
//  LoginViewController.swift
//  Bankey
//
//  Created by HanaTI on 2022/09/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    let stackView = UIStackView()
    let loginView = LoginView()
    let signInButton = LoadingButton(type: .system)
    let errorLabel = UILabel()
    
    let spacing: CGFloat = 8
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    var password: String? {
        return loginView.passwordTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

extension LoginViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = spacing * 2
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.backgroundColor = .systemBlue
        signInButton.titleLabel?.tintColor = .white
        signInButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.layer.cornerRadius = 5
        signInButton.clipsToBounds = true
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .center
        errorLabel.textColor = .systemRed
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
    }
    
    func layout() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(loginView)
        stackView.addArrangedSubview(signInButton)
        stackView.addArrangedSubview(errorLabel)
        
        // StackView
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: Action
extension LoginViewController {
    @objc func signInTapped() {
        if signInButton.activityIndicator != nil {
            signInButton.hideLoading()
        }
        errorLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("username, password 는 nil 이 될 수 없다.")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureErrorLabel(withMessage: "username과 password 는 비어있으면 안됩니다.")
            return
        }
        
        if username == "Koo" && password == "134682" {
            signInButton.showLoading()
        } else {
            configureErrorLabel(withMessage: "username과 password 가 틀립니다.")
        }
    }
    
    private func configureErrorLabel(withMessage message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
}



