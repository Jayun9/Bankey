//
//  ContainerViewController.swift
//  Bankey
//
//  Created by HanaTI on 2022/09/26.
//

import UIKit

class OnBoardingContainerViewController: UIViewController {
    
    let pageViewController = OnBoardingPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal,
        options: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
}
