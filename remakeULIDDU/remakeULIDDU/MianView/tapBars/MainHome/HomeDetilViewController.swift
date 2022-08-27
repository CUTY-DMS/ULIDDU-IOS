//
//  HomeDetilViewController.swift
//  
//
//  Created by 박준하 on 2022/08/26.
//

import UIKit
import SnapKit
import Alamofire

class HomeDetilViewController : UIViewController {
    
    var getTodoEdit : GetToDoList?
    
    var titleEdit: String = ""
    var contentEdit: String = ""
    var dateEdit: String = ""
    
    let titleText = UILabel()
    let contentText = UILabel()
    let dateText = UILabel()
    
    let titleField = UITextField()
    let contentField = UITextField()
    let dateField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        loginAndSignUpTextField()
        titleLabel()
        contentLabel()
        dateLabel()
        
        titleField.text = "\(titleEdit)"
        contentField.text = "\(contentEdit)"
        dateField.text = "\(dateEdit)"
    }
    
    func titleLabel() {
        titleText.textColor = .black
        titleText.text = "제목"
        view.addSubview(titleText)
        
        titleText.font = UIFont.boldSystemFont(ofSize: 20)
        
        titleText.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(200)
            $0.top.equalTo(100)
            $0.leading.equalTo(25)
            
        }
    }
    
    func contentLabel() {
        contentText.textColor = .black
        contentText.text = "내용"
        view.addSubview(contentText)
        
        contentText.font = UIFont.boldSystemFont(ofSize: 20)
        
        contentText.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(200)
            $0.top.equalTo(250)
            $0.leading.equalTo(25)
            
        }
    }
    
    func dateLabel() {
        dateText.textColor = .black
        dateText.text = "날짜"
        view.addSubview(dateText)
        
        dateText.font = UIFont.boldSystemFont(ofSize: 20)
        
        dateText.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(200)
            $0.top.equalTo(400)
            $0.leading.equalTo(25)
            
        }
    }
    
    func loginAndSignUpTextField() {
        
        titleField.borderStyle = .roundedRect
        view.addSubview(titleField)
        titleField.textColor = .black
        titleField.snp.makeConstraints{
            $0.height.equalTo(35)
            $0.width.equalTo(390)
            $0.top.equalTo(150)
            $0.leading.equalTo(20)
        }
        
        contentField.borderStyle = .roundedRect
        contentField.textColor = .black
        view.addSubview(contentField)
        contentField.snp.makeConstraints{
            $0.height.equalTo(35)
            $0.width.equalTo(390)
            $0.top.equalTo(300)
            $0.leading.equalTo(20)
        }
        
        dateField.borderStyle = .roundedRect
        dateField.textColor = .black
        view.addSubview(dateField)
        dateField.snp.makeConstraints{
            $0.height.equalTo(35)
            $0.width.equalTo(390)
            $0.top.equalTo(450)
            $0.leading.equalTo(20)
        }
    }
    
}
