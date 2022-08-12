//
//  MainTabBarController.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/12.
//

import UIKit

class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let publicFeedVC = PublicFeedViewController()
        let mainHomeVC = MainHomeViewController()
        let userVC = UserViewController()
        
        self.viewControllers = [publicFeedVC, mainHomeVC, userVC]
        
        let publicFeedTabBarItem = UITabBarItem(title: "피드",image: UIImage(systemName: "magnifyingglass"), tag: 0)
        let mainHomeTabBarItem = UITabBarItem(title: "나의 todoList", image: UIImage(systemName: "house"), tag: 1)
        let userTabBarItem = UITabBarItem(title: "나의 정보", image: UIImage(systemName: "person"), tag: 2)
        
        publicFeedVC.tabBarItem = publicFeedTabBarItem
        mainHomeVC.tabBarItem = mainHomeTabBarItem
        userVC.tabBarItem = userTabBarItem
    }
}
