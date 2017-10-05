//
//  IntroductionController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/09/23.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Lottie

/// Introduction controller
/// MARK: This screen will make intro screen using Lottie library
/// This will contain 4 screen

class IntroductionController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    var pageControl = UIPageControl()
    let skipButton = UIButton()
    lazy var arrayPage: [UIViewController] = [self.viewControllerAtIndex(index: 0),
                                              self.viewControllerAtIndex(index: 1),
                                              self.viewControllerAtIndex(index: 2),
                                              self.viewControllerAtIndex(index: 3)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        if let initialVc = arrayPage.first {
            setViewControllers([initialVc], direction: .forward, animated: true, completion: nil)
        }
        configurePageControl()
        skipButton.addTarget(self, action: #selector(skipIntroduction), for: .touchUpInside)
        setUpSkipButton()
        navigationController?.isNavigationBarHidden = true 
    }
    
    func setUpSkipButton() {
        skipButton.setTitle("Bỏ qua 〉", for: .normal)
        skipButton.setTitleColor(.white, for: .normal)
        skipButton.setTitleColor(.gray, for: .selected)
        view.addSubview(skipButton)
        skipButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        skipButton.center = CGPoint(x: UIScreen.main.bounds.maxX - 60, y: UIScreen.main.bounds.maxY - 70)
        skipButton.addTarget(self, action: #selector(skipIntroduction), for: .touchUpInside)
    }
    
    @objc func skipIntroduction() {
        let vc = TabbarController()
        let navigationController = UINavigationController(rootViewController: vc)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = navigationController
    }
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
}

extension IntroductionController {
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 100, width: UIScreen.main.bounds.width, height: 50))
        self.pageControl.numberOfPages = arrayPage.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = .black
        self.pageControl.pageIndicatorTintColor = .white
        self.pageControl.currentPageIndicatorTintColor = .black
        self.pageControl.layer.position.y = self.view.frame.height - 100
        self.view.addSubview(pageControl)
    }
    
    ///  - Set current page control
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let pageContentViewController = pageViewController.viewControllers![0] as? ChildIntroductionController else {
            return
        }
        let pageIndex = pageContentViewController.pageIndex
        pageControl.currentPage = pageIndex
        skipButton.isHidden = pageIndex == arrayPage.count - 1
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let curentIndex = arrayPage.index(of: viewController) else { return nil }
        if (curentIndex == 0 ) || (curentIndex == NSNotFound) { return nil }
        let previousIndex = curentIndex - 1
        return arrayPage[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let curentIndex = arrayPage.index(of: viewController) else { return nil }
        if (curentIndex == arrayPage.count - 1) || (curentIndex == NSNotFound) { return nil }
        let nextIndex = curentIndex + 1
        return arrayPage[nextIndex]
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController {
        let sb = UIStoryboard(name: "ChildIntroduction", bundle: nil)
        let vc: ChildIntroductionController = sb.instantiateViewController(withIdentifier: String(describing: ChildIntroductionController.self)) as! ChildIntroductionController
        vc.pageIndex = index
        return vc
    }
}
