//
//  UITextField+SecureToggle.swift
//  Bankey
//
//  Created by HanaTI on 2022/10/04.
//

import UIKit

extension UITextField {
    func setSecurToggleBtn() {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        button.addTarget(self, action: #selector(toggleBtn), for: .touchUpInside)
        
        rightView = button
        rightViewMode = .always
    }
    
    @objc func toggleBtn(_ sender: UIButton) {
        isSecureTextEntry.toggle()
        sender.isSelected.toggle()
        
        if let exsitingText = text {
            deleteBackward()
            if let textRange = textRange(from: beginningOfDocument, to: endOfDocument) {
                replace(textRange, withText: exsitingText)
            }
        }
    }
}
