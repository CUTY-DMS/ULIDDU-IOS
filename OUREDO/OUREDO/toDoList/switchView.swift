//
//  switchView.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/16.
//

import UIKit

class switchView: UIViewController {

    @IBOutlet var valueSwitch: UISwitch!
    var isswitchOn = false
    override func awakeFromNib() {
        super.viewDidLoad()
        
        valueSwitch.isOn = isswitchOn
    }
}

