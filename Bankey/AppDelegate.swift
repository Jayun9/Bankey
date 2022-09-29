//
//  AppDelegate.swift
//  Bankey
//
//  Created by HanaTI on 2022/09/23.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UIPageViewControllerDelegate {
    var window: UIWindow?

    let loginViewController = LoginViewController()
    let onboardingViewContainerContainer = OnBoardingContainerViewController()
    let dummyViewController = DummyViewController()
    let mainController = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingViewContainerContainer.pageViewController.onboardingDelegate = self
        dummyViewController.logoutDelegate = self
        window?.rootViewController = AccountSummaryViewController()
        

        return true
    }
}

// MARK: - LoginViewControllerDelegate
extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(dummyViewController)
        } else {
            setRootViewController(onboardingViewContainerContainer)
        }
    }
}

// MARK: - OnBoardingPageViewControllerDelegate
extension AppDelegate: OnBoardingPageViewControllerDelegate {
    func didOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(dummyViewController)
    }
}

// MARK: - LogoutDelegate
extension AppDelegate: LogoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil)
    }
}

