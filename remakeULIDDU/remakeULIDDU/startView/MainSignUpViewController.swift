//
//  MainSignUpViewController.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/13.
//

import UIKit
import Alamofire

class MainSignUpViewController : UIViewController {
    
    let NameField = UITextField()
    let idFidld = UITextField()
    let passworldField = UITextField()
    let ageField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        signUpText()
        nameViewLine()
        idViewLine()
        passworldViewLine()
        ageViewLine()
        NameAndIdAndPassAndAgeTextField()
        configureSignUpButton()
    }
    
    func signUpText() {
        let loginLabel = UILabel()
        loginLabel.textColor = .black
        loginLabel.text = "SignUp"
        view.addSubview(loginLabel)
        
        loginLabel.font = UIFont.boldSystemFont(ofSize: 35)
        
        loginLabel.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(200)
            $0.trailing.equalTo(-100)
            $0.bottom.equalTo(-700)
            $0.leading.equalTo(160)
            
        }
    }

    func nameViewLine() {
        let signUpLine = UIView()
        view.addSubview(signUpLine)
        signUpLine.backgroundColor = .black
        signUpLine.snp.makeConstraints{
            $0.height.equalTo(2)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(330)
            $0.leading.equalTo(45)
        }
    }

    func idViewLine() {
        let signUpLine = UIView()
        view.addSubview(signUpLine)
        signUpLine.backgroundColor = .black
        signUpLine.snp.makeConstraints{
            $0.height.equalTo(2)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(400)
            $0.leading.equalTo(45)
        }
    }

    func passworldViewLine() {
        let signUpLine = UIView()
        view.addSubview(signUpLine)
        signUpLine.backgroundColor = .black
        signUpLine.snp.makeConstraints{
            $0.height.equalTo(2)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(470)
            $0.leading.equalTo(45)
        }
    }
    
    func ageViewLine() {
        let signUpLine = UIView()
        view.addSubview(signUpLine)
        signUpLine.backgroundColor = .black
        signUpLine.snp.makeConstraints{
            $0.height.equalTo(2)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(540)
            $0.leading.equalTo(45)
        }
    }
    
    func NameAndIdAndPassAndAgeTextField() {
        
        NameField.borderStyle = .none
        view.addSubview(NameField)
        NameField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        NameField.textColor = .black
        NameField.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(295)
            $0.leading.equalTo(45)
        }
        
        idFidld.borderStyle = .none
        view.addSubview(idFidld)
        idFidld.attributedPlaceholder = NSAttributedString(string: "Id", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        idFidld.textColor = .black
        idFidld.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(365)
            $0.leading.equalTo(45)
        }
        
        passworldField.borderStyle = .none
        passworldField.attributedPlaceholder = NSAttributedString(string: "Passworld", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passworldField.textColor = .black
        passworldField.isSecureTextEntry = true
        view.addSubview(passworldField)
        passworldField.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(435)
            $0.leading.equalTo(45)
        }
        
        ageField.borderStyle = .none
        view.addSubview(ageField)
        ageField.attributedPlaceholder = NSAttributedString(string: "Age", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        ageField.textColor = .black
        ageField.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.top.equalTo(505)
            $0.leading.equalTo(45)
        }
    }
    
    func configureSignUpButton() {
        let loginButton = UIButton()
        loginButton.setTitle("Sign in", for: .normal)
        loginButton.backgroundColor = .black
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loginButton)
        
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        loginButton.snp.makeConstraints{
            $0.height.equalTo(55)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.bottom.equalTo(-200)
            $0.leading.equalTo(45)
        }
        
        loginButton.addTarget(self, action: #selector(loginbuttonAction), for: .touchUpInside)
        
        }
    
    @objc func loginbuttonAction(sender: UIButton!){
        postsignUp()
        print("------------------------------")
        print("Name : \(NameField.text!)")
        print("Id : \(idFidld.text!)")
        print("Password : \(passworldField.text!)")
        print("Age : \(ageField.text!)")
        print("------------------------------")

    }
    
    func postsignUp() {
            let url = "http://44.209.75.36:8080/register"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10
            // POST 로 보낼 정보
        print(url)
        let params = [
            "name": NameField.text!,
            "age":ageField.text!,
            "user-id":idFidld.text!,
            "password":passworldField.text!
                     ] as Dictionary
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        request.httpBody = jsonData

        AF.request(url,method: .post,parameters: params, encoding: JSONEncoding.default)
            .responseString { (response) in
            debugPrint(response)
                
                switch response.response?.statusCode {
                case 200:
                    print("✅POST 성공✅")
                    let goToMainTabBarVC = MainTabBarController()
                    goToMainTabBarVC.modalPresentationStyle = .fullScreen
                    self.present(goToMainTabBarVC, animated: true, completion: nil)
                case 204:
                    print("😆POST 성공😆")
                    let goToMainTabBarVC = FirstViewController()
                    goToMainTabBarVC.modalPresentationStyle = .fullScreen
                    self.present(goToMainTabBarVC, animated: true, completion: nil)
                    
                default:
                    print("hi error 🚫")
                    let AlertMassge = UIAlertController(title: "경고", message: "비밀번호는 8글자 이상 해주세요", preferredStyle: UIAlertController.Style.alert)
                    let ActionMassge = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    
                    AlertMassge.addAction(ActionMassge)
                    self.present(AlertMassge, animated: true, completion: nil)
                }
            }
        }
    

}


//view미리보기
import SwiftUI

struct SignUpViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainSignUpViewController {
        return MainSignUpViewController()
    }
    
    func updateUIViewController(_ uiViewController: MainSignUpViewController, context: Context) { }
    
    
    typealias UIViewControllerType = MainSignUpViewController
}

@available(iOS 13.0.0, *)
struct SignUpViewPreview: PreviewProvider {
    static var previews: some View {
        SignUpViewControllerRepresentable()
    }
}
