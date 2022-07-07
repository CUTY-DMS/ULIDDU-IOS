//
//  ViewController.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/01.
//

import UIKit
import SideMenu

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonClicked(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let sideMenuViewController : SideMenuVC = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        
        let menu = customSideMenuNavigation(rootViewController: sideMenuViewController)
        
        present(menu, animated: true, completion: nil)
    }
}
