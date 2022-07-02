//
//  loginHomeVC.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/01.
//

import UIKit

class LoginHomeVC: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    var redius = 19
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = CGFloat(redius)
        signUpButton.layer.cornerRadius = CGFloat(redius)
    }


}

