//
//  TabBarController.swift
//  ThoughtTracker
//
//  Created by John Bogil on 12/2/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let thoughtsVC = ThoughtsVC()
        thoughtsVC.title = "Today's Thoughts"
        let navController = UINavigationController(rootViewController: thoughtsVC)
        let pageVC = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.title = "Education"
        self.viewControllers = [pageVC, navController]
        self.selectedIndex = 1
    }

}
