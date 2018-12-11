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
        navController.tabBarItem.image = #imageLiteral(resourceName: "icon_today")
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
        navController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 7)
        let pageVC = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.tabBarItem.image = #imageLiteral(resourceName: "icon_learn")
        pageVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 7)
        pageVC.tabBarItem.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
        pageVC.title = "Learn"
        self.viewControllers = [pageVC, navController]
        self.selectedIndex = 1
    }

}
