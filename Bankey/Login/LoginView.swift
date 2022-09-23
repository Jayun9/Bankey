//
//  LoginView.swift
//  Bankey
//
//  Created by HanaTI on 2022/09/23.
//

import UIKit

class LoginView: UIView {
    
    let stackVIew = UIStackView()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let devideView = UIView()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Style, Layout
extension LoginView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 5
        clipsToBounds = true 
        
        stackVIew.translatesAutoresizingMaskIntoConstraints = false
        stackVIew.axis = .vertical
        stackVIew.spacing = 8
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "Username"
        usernameTextField.delegate = self
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        
        devideView.translatesAutoresizingMaskIntoConstraints = false
        devideView.backgroundColor = .secondarySystemFill
    }
    
    func layout() {
        addSubview(stackVIew)
        
        stackVIew.addArrangedSubview(usernameTextField)
        stackVIew.addArrangedSubview(devideView)
        stackVIew.addArrangedSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            stackVIew.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            stackVIew.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackVIew.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackVIew.bottomAnchor, multiplier: 1),
            
            devideView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
    }
}

// MARK: UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
