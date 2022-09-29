//
//  UIViewController+Utils.swift
//  Bankey
//
//  Created by HanaTI on 2022/09/27.
//

import UIKit

extension UIViewController {
    func setStatusBar() {
        let navApearenc = UINavigationBarAppearance()
        navApearenc.configureWithTransparentBackground()
        navApearenc.backgroundColor = appColor
        UINavigationBar.appearance().standardAppearance = navApearenc
        UINavigationBar.appearance().scrollEdgeAppearance = navApearenc
    }
    
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}
