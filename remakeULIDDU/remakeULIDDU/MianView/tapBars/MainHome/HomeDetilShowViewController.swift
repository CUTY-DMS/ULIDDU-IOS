//
//  HomeDetilShowViewController.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/27.
//

import UIKit

class HomeDetilShowViewController : UIViewController {
    
    var getTodoWrite : UserDetailTodo?

    
    var showId : String = ""
    var showTitle : String = ""
    var showContent : String = ""
    var showWriter : String = ""
    var showTodoDate : String = ""
    var showCompleteDate : String = ""
    var showIscompleted : String = ""
    var showIspublic : Bool = true
    var showIsliked : Bool = false
    var showLikeCount : Int = 0
    

    
    let titleText = UILabel()
    let contentText = UILabel()
    let dateText = UILabel()
    let publicText = UILabel()
    
    let titleWrite = UILabel()
    let contentWrite = UILabel()
    let dateWrite = UILabel()
    let publicWrite = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        titleLabel()
        contentLabel()
        dateLabel()
        pubilcLabel()
        
        userWrite()
        
        configureEditButton()
    }
    
    func titleLabel() {
        titleText.textColor = .black
        titleText.text = "제목"
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
        contentText.text = "내용"
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
        dateText.text = "날짜"
        view.addSubview(dateText)
        
        dateText.font = UIFont.boldSystemFont(ofSize: 20)
        
        dateText.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(200)
            $0.top.equalTo(280)
            $0.leading.equalTo(25)
            
        }
    }
    func pubilcLabel() {
        publicText.textColor = .black
        publicText.text = "공개 여부"
        view.addSubview(publicText)
        
        publicText.font = UIFont.boldSystemFont(ofSize: 20)
        
        publicText.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(200)
            $0.top.equalTo(410)
            $0.leading.equalTo(25)
            
        }
    }

    
    
    func userWrite() {
        
        titleWrite.textColor = .black
        titleWrite.text = "\(getTodoWrite!.title)"
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
        contentWrite.text = "\(showContent)"
        view.addSubview(contentWrite)
        
        contentWrite.font = UIFont.boldSystemFont(ofSize: 20)
        
        contentWrite.snp.makeConstraints{
            $0.height.equalTo(35)
            $0.width.equalTo(390)
            $0.top.equalTo(200)
            $0.leading.equalTo(25)
        }
        
        dateWrite.textColor = .black
        dateWrite.text = "\(showTodoDate)"
        view.addSubview(dateWrite)
        
        dateWrite.font = UIFont.boldSystemFont(ofSize: 20)
        
        dateWrite.snp.makeConstraints{
            $0.height.equalTo(35)
            $0.width.equalTo(390)
            $0.top.equalTo(330)
            $0.leading.equalTo(25)
        }
        
        publicWrite.textColor = .black
        publicWrite.text = "\(showIspublic)"
        view.addSubview(publicWrite)
        
        publicWrite.font = UIFont.boldSystemFont(ofSize: 20)
        
        publicWrite.snp.makeConstraints{
            $0.height.equalTo(35)
            $0.width.equalTo(390)
            $0.top.equalTo(460)
            $0.leading.equalTo(25)
        }
    }
    func configureEditButton() {
        
        let editButton = UIButton()
        editButton.setTitle("수정", for: .normal)
        editButton.setTitleColor(.black, for: .normal)
        editButton.backgroundColor = .white
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        editButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        view.addSubview(editButton)
        
        editButton.snp.makeConstraints{
            $0.height.equalTo(55)
            $0.width.equalTo(325)
            $0.top.equalTo(550)
            $0.leading.equalTo(50)
        }
        
        editButton.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
        
        }
    @objc func editButtonAction(sender: UIButton!){
        print("수정버튼 🔨")
        let homeDetil = HomeDetilEditViewController()
        homeDetil.titleEdit = "\(titleWrite.text!)"
        homeDetil.contentEdit = "\(contentWrite.text!)"
//        homeDetil.dateEdit = "\(dateWrite.text!)"
//        homeDetil.pubilcEdit = "\(publicWrite.text!)"
        homeDetil.userId = getTodoWrite!.id
        
        self.show(homeDetil, sender: nil)
    }
}
