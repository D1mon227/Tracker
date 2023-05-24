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
        let trackerNavigationController = UINavigationController(rootViewController: TrackerViewController())
        let statisticNavigationController = UINavigationController(rootViewController: StatisticViewController())
        
        trackerNavigationController.navigationBar.prefersLargeTitles = true
        trackerNavigationController.navigationItem.largeTitleDisplayMode = .automatic
        trackerNavigationController.navigationBar.topItem?.title = "Трекеры"
        
        statisticNavigationController.navigationBar.prefersLargeTitles = true
        statisticNavigationController.navigationItem.largeTitleDisplayMode = .automatic
        statisticNavigationController.navigationBar.topItem?.title = "Статистика"
        
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.ypGray.cgColor
        
        trackerNavigationController.tabBarItem = UITabBarItem(title: "Трекеры",
                                                        image: UIImage(systemName: "record.circle.fill"),
                                                        selectedImage: nil)
        statisticNavigationController.tabBarItem = UITabBarItem(title: "Статистика",
                                                          image: UIImage(systemName: "hare.fill"),
                                                          selectedImage: nil)
        
        self.viewControllers = [trackerNavigationController, statisticNavigationController]
    }
}
