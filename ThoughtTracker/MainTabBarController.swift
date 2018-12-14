//
//  TabBarController.swift
//  ThoughtTracker
//
//  Created by John Bogil on 12/2/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation
import UIKit
import DefaultsKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let thoughtsVC = ThoughtsVC()
        thoughtsVC.title = "Today's Thoughts"
        let navController = UINavigationController(rootViewController: thoughtsVC)
        navController.tabBarItem.image = #imageLiteral(resourceName: "icon_today")
        let pageVC = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.tabBarItem.image = #imageLiteral(resourceName: "icon_learn")
        pageVC.title = "Learn"
        self.viewControllers = [pageVC, navController]

        self.selectedIndex = 0
        if let thoughtCount = defaults.get(for: .thoughtsKey), thoughtCount.count > 0 {
            self.selectedIndex = 1
        }
    }
}
