//
//  MainViewController.swift
//  Bankey
//
//  Created by HanaTI on 2022/09/28.
//
import UIKit

class MainViewController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
    
}

extension MainViewController {
    func setup() {
        let api = API(baseUrl: "https://fierce-retreat-36855.herokuapp.com/bankey")
        let accountViewModel = AccountViewModel(api: api)
        let vc1 = AccountSummaryViewController(viewModel: accountViewModel)
        let vc2 = ViewController2()
        let vc3 = ViewController3()
        
        vc1.setTabBarImage(imageName:  "list.dash", title:  "Summary")
        vc2.setTabBarImage(imageName:  "arrow.left.arrow.right", title:  "Move Money")
        vc3.setTabBarImage(imageName:  "ellipsis.circle", title:  "More")
        
        let nvc1 = UINavigationController(rootViewController: vc1)
        let nvc2 = UINavigationController(rootViewController: vc2)
        let nvc3 = UINavigationController(rootViewController: vc3)
        
        viewControllers = [nvc1, nvc2, nvc3]
    }
    
    func style() {
        setStatusBar()
        tabBar.tintColor = appColor
        tabBar.isTranslucent = false 
    }
    
    func layout() {
    }
}

class ViewController1: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}
class ViewController2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
    }
}
class ViewController3: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
}
