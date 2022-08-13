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
        
        //어떤건지 정의해줌
        let publicFeedVC = PublicFeedViewController()
        let mainHomeVC = MainHomeViewController()
        let userVC = UserViewController()
        
        //배열순으로 탭바에 들어감
        self.viewControllers = [publicFeedVC, mainHomeVC, userVC]
        
        //tabbarItem을 정해줌
        let publicFeedTabBarItem = UITabBarItem(title: "피드",image: UIImage(systemName: "magnifyingglass"), tag: 0)
        let mainHomeTabBarItem = UITabBarItem(title: "나의 todoList", image: UIImage(systemName: "house"), tag: 1)
        let userTabBarItem = UITabBarItem(title: "나의 정보", image: UIImage(systemName: "person"), tag: 2)
        
        //정의된 것에 tabbarItem을 지정해줌
        publicFeedVC.tabBarItem = publicFeedTabBarItem
        mainHomeVC.tabBarItem = mainHomeTabBarItem
        userVC.tabBarItem = userTabBarItem
    }
}

