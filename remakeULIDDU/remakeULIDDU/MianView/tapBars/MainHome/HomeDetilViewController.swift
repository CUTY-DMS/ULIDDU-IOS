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
    var pubilcEdit : String = ""
    var userId: Int = 0
    
    let titleText = UILabel()
    let contentText = UILabel()
    let dateText = UILabel()
    
    let titleField = UITextField()
    let contentField = UITextField()
    let pubilcSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        loginAndSignUpTextField()
        titleLabel()
        contentLabel()
        dateLabel()
        
        titleField.text = "\(titleEdit)"
        contentField.text = "\(contentEdit)"
//        dateField.text = "\(dateEdit)"
//        pubilField.text = "\(pubilcEdit)"
        
        configureOkButton()
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
        dateText.text = "공개여부"
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
        pubilcSwitch.isOn = true
        pubilcSwitch.addTarget(self, action: #selector(onClickSwitch(sender:)), for: UIControl.Event.valueChanged)
        
        view.addSubview(pubilcSwitch)
        pubilcSwitch.snp.makeConstraints{
            $0.height.equalTo(35)
            $0.width.equalTo(390)
            $0.top.equalTo(450)
            $0.leading.equalTo(20)
        }
    }
    
    @objc func onClickSwitch(sender: UISwitch) {
        if sender.isOn {
            print("공유")
        } else {
            print("공유하지 않음")
        }
    }
    
    func configureOkButton() {
        
        let okButton = UIButton()
        okButton.setTitle("수정 완료", for: .normal)
        okButton.setTitleColor(.black, for: .normal)
        okButton.backgroundColor = .white
        okButton.translatesAutoresizingMaskIntoConstraints = false
        
        okButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        view.addSubview(okButton)
        
        okButton.snp.makeConstraints{
            $0.height.equalTo(55)
            $0.width.equalTo(325)
            $0.top.equalTo(550)
            $0.leading.equalTo(50)
        }
        
        okButton.addTarget(self, action: #selector(okButtonAction), for: .touchUpInside)
        
        }
    @objc func okButtonAction(sender: UIButton!){
        print("수정완료버튼 🌹")
        userEditPatch()
    }
    
    func userEditPatch() {
            let url = "http://44.209.75.36:8080/todo/\(userId)"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10
            // POST 로 보낼 정보
        print(url)
        let params = [
            "title" : "\(titleField)",
            "content" : "\(contentField)"
//            "ispublic" : pubilField
                     ] as Dictionary
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        request.httpBody = jsonData

        AF.request(url,method: .patch,parameters: params, encoding: JSONEncoding.default)
            .responseString { (response) in
            debugPrint(response)
                
                switch response.response?.statusCode {
                case 200:
                    print("✅patch 성공✅")
                    let AlertMassge = UIAlertController(title: "성공", message: "수정을 성공하였습니다", preferredStyle: UIAlertController.Style.alert)
                    let ActionMassge = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    
                    AlertMassge.addAction(ActionMassge)
                    self.present(AlertMassge, animated: true, completion: nil)
                    let goToMainHomeVC = MainHomeViewController()
                    goToMainHomeVC.modalPresentationStyle = .fullScreen
                    self.present(goToMainHomeVC, animated: true, completion: nil)
                case 204:
                    print("✅patch 성공✅")
                    let AlertMassge = UIAlertController(title: "성공", message: "수정을 성공하였습니다", preferredStyle: UIAlertController.Style.alert)
                    let ActionMassge = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    
                    AlertMassge.addAction(ActionMassge)
                    self.present(AlertMassge, animated: true, completion: nil)
                    self.present(AlertMassge, animated: true, completion: nil)
                    let goToMainHomeVC = MainHomeViewController()
                    goToMainHomeVC.modalPresentationStyle = .fullScreen
                    self.present(goToMainHomeVC, animated: true, completion: nil)
                    
                default:
                    print("hi error 🚫")
                    let AlertMassge = UIAlertController(title: "경고", message: "수정을 실패하였습니다", preferredStyle: UIAlertController.Style.alert)
                    let ActionMassge = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    
                    AlertMassge.addAction(ActionMassge)
                    self.present(AlertMassge, animated: true, completion: nil)
                }
            }
        }
    
}
