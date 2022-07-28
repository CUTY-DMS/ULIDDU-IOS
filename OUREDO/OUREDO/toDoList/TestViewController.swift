//
//  TextViewController.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/27.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    var date: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myLabel.text = date
    }
}
