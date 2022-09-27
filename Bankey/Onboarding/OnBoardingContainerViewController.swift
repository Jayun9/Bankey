//
//  OnBoardingContainerViewController.swift
//  Bankey
//
//  Created by HanaTI on 2022/09/26.
//

import UIKit

// MARK: - OnboardingContainerViewControllerDelegate
protocol OnBoardingContainerViewControllerDelegate: AnyObject {
    func didOnboarding()
}

class OnBoardingContainerViewController: UIViewController {
    
    let pageViewController: UIPageViewController
    var pages: [UIViewController] = []
    var currentPage: UIViewController
    
    let prevButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    let doneButton = UIButton(type: .system)
    
    weak var delegate: OnBoardingContainerViewControllerDelegate?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil)
        
        let VC1 = OnBoardingViewController(
            imageName: "delorean",
            titleMessage: "매우빠른 스피드를 자랑하는 Bankey를 사용하세요")
        let VC2 = OnBoardingViewController(
            imageName: "world",
            titleMessage: "전 세계 절반은 Bankey 를 사용합니다")
        let VC3 = OnBoardingViewController(
            imageName: "thumbs",
            titleMessage: "구독과 좋아요 부탁드립니다.")
        pages.append(VC1)
        pages.append(VC2)
        pages.append(VC3)
        
        currentPage = pages.first!
        super.init(nibName: nil, bundle: nil)
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

// MARK: - setup
extension OnBoardingContainerViewController {
    func setup() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.setViewControllers(
            [pages.first!],
            direction: .forward,
            animated: true,
            completion: nil)
    }
    
    
    func style() {
        view.backgroundColor = .systemPurple
        
        // prevButton
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        prevButton.setTitle("Prev", for: [])
        prevButton.addTarget(self, action: #selector(prevTapped), for: .primaryActionTriggered)
        prevButton.isHidden = true
        
        // nextButton
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: [])
        nextButton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
        
        // DoneButton
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", for: [])
        doneButton.addTarget(self, action: #selector(doneTapped), for: .primaryActionTriggered)
        doneButton.isHidden = true
    }
    
    func layout() {
        view.addSubview(prevButton)
        view.addSubview(nextButton)
        view.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // prevButton
        NSLayoutConstraint.activate([
            prevButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: prevButton.bottomAnchor, multiplier: 5)
        ])
        
        // nextButton
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: nextButton.bottomAnchor, multiplier: 5)
        ])
        
        // doneButton
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: doneButton.trailingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: doneButton.bottomAnchor, multiplier: 5)
        ])
    }
}

// MARK: - UIPageViewControllerDatasource
extension OnBoardingContainerViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else {
            return nil
        }
        currentPage = pages[index + 1]
        return currentPage
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else {
            return nil
        }
        currentPage = pages[index - 1]
        return currentPage
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: currentPage) ?? 0
    }
}

// MARK: - UIPageViewControllerDelegate
extension OnBoardingContainerViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed, let currentVc = pageViewController.viewControllers?.first else {
            return
        }
        prevButton.isHidden = true
        nextButton.isHidden = true
        doneButton.isHidden = true
        let index = pages.firstIndex(of: currentVc) ?? 0
        if index == 0 {
            nextButton.isHidden = false
        } else if index == pages.endIndex - 1 {
            prevButton.isHidden = false
            doneButton.isHidden = false
        } else {
            prevButton.isHidden = false
            nextButton.isHidden = false
        }
        
    }
}

// MARK: - Actions
extension OnBoardingContainerViewController {
    @objc func prevTapped() {
        guard let currentVc = pageViewController.viewControllers?[0] as? OnBoardingViewController else { return }
        guard let index = pages.firstIndex(of: currentVc) else { return }
        
        setPagingViewController(index: index - 1)
    }
    
    @objc func nextTapped() {
//        setPagingViewController(index: setIndex + 1)
    }
    
    @objc func doneTapped() {
        delegate?.didOnboarding()
    }
    
    private func setPagingViewController(index: Int) {
        pageViewController.setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
}
