//
//  SideMenuVC.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/07.
//

import UIKit
import SideMenu

class customSideMenuNavigation : SideMenuNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presentationStyle = .menuSlideIn
        
        //50%만 보여주고 싶다면
        self.menuWidth = self.view.frame.width * 0.5
        
        //상태바를 보여주고 싶다면
        self.statusBarEndAlpha = 0.0
        
        //보여지는 속도
        self.presentDuration = 1.5
        
        //사라지는 속도
        self.dismissDuration = 1.5
    }
}
