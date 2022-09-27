//
//  OnBoardingPageViewController.swift
//  Bankey
//
//  Created by HanaTI on 2022/09/26.
//

import UIKit

protocol OnBoardingPageViewControllerDelegate: AnyObject {
    func didOnboarding()
}

class OnBoardingPageViewController: UIPageViewController {
    
    let pageControl = UIPageControl()
    var pages: [UIViewController] = []
    
    let closeButton = UIButton(type: .system)
    let prevButton = UIButton(type: .system)
    let doneButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    
    var currentIndex: Int?
    var pendingIndex: Int?
    
    weak var onboardingDelegate: OnBoardingPageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

extension OnBoardingPageViewController {
    func setup() {
        let page1 = OnBoardingViewController(
            imageName: "delorean",
            titleMessage: "매우빠른 스피드를 자랑하는 Bankey를 사용하세요")
        let page2 = OnBoardingViewController(
            imageName: "world",
            titleMessage: "전 세계 절반은 Bankey 를 사용합니다")
        let page3 = OnBoardingViewController(
            imageName: "thumbs",
            titleMessage: "구독과 좋아요 부탁드립니다.")
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        dataSource = self
        delegate = self
        setViewControllers([pages.first!], direction: .forward, animated: true, completion: nil)
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
    }
    
    func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.backgroundColor = .systemPurple
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        currentIndex = 0
        
        // closButton
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(self, action: #selector(doneTapped), for: .primaryActionTriggered)
        // nextButton
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: [])
        nextButton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
        // prevButton
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        prevButton.setTitle("Prev", for: [])
        prevButton.addTarget(self, action: #selector(prevTapped), for: .primaryActionTriggered)
        // doneButton
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", for: [])
        doneButton.addTarget(self, action: #selector(doneTapped), for: .primaryActionTriggered)
        
        setButtonVisible(0)
    }
    
    func layout() {
        view.addSubview(pageControl)
        view.addSubview(closeButton)
        view.addSubview(nextButton)
        view.addSubview(prevButton)
        view.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // closeButton
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        ])
        // prevButton
        NSLayoutConstraint.activate([
            prevButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            pageControl.topAnchor.constraint(equalToSystemSpacingBelow: prevButton.bottomAnchor, multiplier: 2)
        ])
        // nextButton
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
            pageControl.topAnchor.constraint(equalToSystemSpacingBelow: nextButton.bottomAnchor, multiplier: 2)
        ])
        // doneButton
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: doneButton.trailingAnchor, multiplier: 2),
            pageControl.topAnchor.constraint(equalToSystemSpacingBelow: doneButton.bottomAnchor, multiplier: 2)
        
        ])
    }
    
    private func setButtonVisible(_ index: Int) {
        prevButton.isHidden = true
        nextButton.isHidden = true
        doneButton.isHidden = true
        
        if index == 0 {
            nextButton.isHidden = false
        } else if index == pages.count - 1 {
            prevButton.isHidden = false
            doneButton.isHidden = false
        } else {
            prevButton.isHidden = false
            nextButton.isHidden = false
        }
    }
}

extension OnBoardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else {
            return nil
        }
        let nextIndex = index + 1
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.lastIndex(of: viewController), index - 1 >= 0 else {
            return nil
        }
        let prevIndex = index - 1
        return pages[prevIndex]
    }

}

extension OnBoardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let pendingVC = pendingViewControllers.first else { return }
        pendingIndex = pages.firstIndex(of: pendingVC)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        currentIndex = pendingIndex
        if let index = currentIndex {
            pageControl.currentPage = index
            setButtonVisible(index)
        }
    }
    
}

extension OnBoardingPageViewController {
    @objc func pageControlTapped(_ sender: UIPageControl) {
        let clickIndex = sender.currentPage
        let direction: UIPageViewController.NavigationDirection
        if let index = currentIndex {
            if clickIndex > index { direction = .forward}
            else { direction = .reverse}
        } else {
            direction = .forward
        }
        currentIndex = clickIndex
        setViewControllers([pages[clickIndex]], direction: direction, animated: true, completion: nil)
        setButtonVisible(clickIndex)
    }
    
    @objc func prevTapped() {
        let index = pageControl.currentPage - 1
        setViewControllers([pages[index]], direction: .reverse, animated: true, completion: nil)
        pageControl.currentPage = index
        setButtonVisible(index)
    }
    
    @objc func nextTapped() {
        let index = pageControl.currentPage + 1
        setViewControllers([pages[index]], direction: .forward , animated: true, completion: nil)
        pageControl.currentPage = index
        setButtonVisible(index)
    }
    
    @objc func doneTapped() {
        onboardingDelegate?.didOnboarding()
    }
}
