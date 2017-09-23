//
//  DemoTableViewController.swift
//  TestCollectionView
//
//  Created by Alex K. on 24/05/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class DemoTableViewController: ExpandingTableViewController {
  
  fileprivate var scrollOffsetY: CGFloat = 0
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavBar()
    let image1 = Asset.backgroundImage.image
    tableView.backgroundView = UIImageView(image: image1)
  }
  
  @IBOutlet weak var titleImageView: UIImageView!
  @IBOutlet weak var titleImageViewXConstraint: NSLayoutConstraint!
  
}

// MARK: - Lifecycle
extension DemoTableViewController {
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    guard let titleView = navigationItem.titleView else { return }
    let center = UIScreen.main.bounds.midX
    let diff = center - titleView.frame.midX
    titleImageViewXConstraint.constant = diff
  }
  
}

// MARK: Helpers
extension DemoTableViewController {
  
  fileprivate func configureNavBar() {
    navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    navigationItem.rightBarButtonItem?.image = navigationItem.rightBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
  }
  
}

// MARK: Actions
extension DemoTableViewController {
  
  @IBAction func backButtonHandler(_ sender: AnyObject) {
    // buttonAnimation
    let viewControllers: [DemoViewController?] = navigationController?.viewControllers.map { $0 as? DemoViewController } ?? []

    for viewController in viewControllers {
      if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimatingBarButton {
        rightButton.animationSelected(false)
      }
    }
    popTransitionAnimation()
  }
}

// MARK: UIScrollViewDelegate
extension DemoTableViewController {
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    if scrollView.contentOffset.y < -25 {
//      // buttonAnimation
//      let viewControllers: [DemoViewController?] = navigationController?.viewControllers.map { $0 as? DemoViewController } ?? []
//
//      for viewController in viewControllers {
//        if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimatingBarButton {
//          rightButton.animationSelected(false)
//        }
//      }
//      popTransitionAnimation()
//    }
    
    scrollOffsetY = scrollView.contentOffset.y
  }
}
