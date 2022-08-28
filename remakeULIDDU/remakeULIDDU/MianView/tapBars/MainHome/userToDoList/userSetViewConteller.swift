//
//  userSetViewConteller.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/28.
//

import UIKit
import SnapKit
import Alamofire

class userSetViewConteller : UIViewController {
    
    var userView: UserContent = UserContent(name: "null", userID: "", age: 0)
    
    let titleText = UILabel()
    let contentText = UILabel()
    let dateText = UILabel()
    let publicText = UILabel()
    
    let titleWrite = UILabel()
    let contentWrite = UILabel()
    let dateWrite = UILabel()
    let publicWrite = UILabel()
    
    var userName : String = ""
    var userId : String = ""
    var userAge : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        titleLabel()
        contentLabel()
        dateLabel()
        userWrite()
    }
    
    func titleLabel() {
        titleText.textColor = .black
        titleText.text = "이름"
        view.addSubview(titleText)
        
        titleText.font = UIFont.boldSystemFont(ofSize: 20)
        
        titleText.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(200)
            $0.top.equalTo(20)
            $0.leading.equalTo(25)
            
        }
    }

    func contentLabel() {
        contentText.textColor = .black
        contentText.text = "ID"
        view.addSubview(contentText)
        
        contentText.font = UIFont.boldSystemFont(ofSize: 20)
        
        contentText.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(200)
            $0.top.equalTo(150)
            $0.leading.equalTo(25)
            
        }
    }

    func dateLabel() {
        dateText.textColor = .black
        dateText.text = "나이"
        view.addSubview(dateText)
        
        dateText.font = UIFont.boldSystemFont(ofSize: 20)
        
        dateText.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(200)
            $0.top.equalTo(280)
            $0.leading.equalTo(25)
            
        }
    }


    func userWrite() {
        
        titleWrite.textColor = .black
        titleWrite.text = "\(userName)"
        view.addSubview(titleWrite)
        
        titleWrite.font = UIFont.boldSystemFont(ofSize: 20)
        
        titleWrite.snp.makeConstraints{
            $0.height.equalTo(35)
            $0.width.equalTo(390)
            $0.top.equalTo(70)
            $0.leading.equalTo(25)
        }
        
        contentWrite.textColor = .black
        //임시 원래는 content값이 들어가야함
        contentWrite.text = "\(userId)"
        view.addSubview(contentWrite)
        
        contentWrite.font = UIFont.boldSystemFont(ofSize: 20)
        
        contentWrite.snp.makeConstraints{
            $0.height.equalTo(35)
            $0.width.equalTo(390)
            $0.top.equalTo(200)
            $0.leading.equalTo(25)
        }
        
        dateWrite.textColor = .black
        dateWrite.text = "\(userAge)"
        view.addSubview(dateWrite)
        
        dateWrite.font = UIFont.boldSystemFont(ofSize: 20)
        
        dateWrite.snp.makeConstraints{
            $0.height.equalTo(35)
            $0.width.equalTo(390)
            $0.top.equalTo(330)
            $0.leading.equalTo(25)
        }
    }
}
