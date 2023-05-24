//
//  TabBarController.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 24.05.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let trackerViewController = TrackerViewController()
        let statisticViewController = StatisticViewController()
        
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.ypGray.cgColor
        
        trackerViewController.tabBarItem = UITabBarItem(title: "Трекеры",
                                                        image: UIImage(systemName: "record.circle.fill"),
                                                        selectedImage: nil)
        statisticViewController.tabBarItem = UITabBarItem(title: "Статистика",
                                                          image: UIImage(systemName: "hare.fill"),
                                                          selectedImage: nil)
        
        self.viewControllers = [trackerViewController, statisticViewController]
    }
}
