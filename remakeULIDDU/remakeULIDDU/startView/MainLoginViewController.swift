//
//  mainLoginViewController.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/12.
//

import UIKit
import SnapKit
import Alamofire

class MainLoginViewController : UIViewController {
    
    let idField = UITextField()
    let passworldField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(KeyChain.read(key: Token.accessToken))
//        print(KeyChain.read(key: Token.refreshToken))
        
        view.backgroundColor = .white

        configureLoginButton()
        configureSignUpButton()
        loginViewLine()
        signUpViewLine()
        loginText()
        loginAndSignUpTextField()
    }
    
    func loginViewLine() {
        let loginLine = UIView()
        view.addSubview(loginLine)
        loginLine.backgroundColor = .black
        loginLine.snp.makeConstraints{
            $0.height.equalTo(2)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.bottom.equalTo(-500)
            $0.leading.equalTo(45)
        }
    }
    
    func signUpViewLine() {
        let signUpLine = UIView()
        view.addSubview(signUpLine)
        signUpLine.backgroundColor = .black
        signUpLine.snp.makeConstraints{
            $0.height.equalTo(2)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.bottom.equalTo(-420)
            $0.leading.equalTo(45)
        }
    }
    
    func loginText() {
        let loginLabel = UILabel()
        loginLabel.textColor = .black
        loginLabel.text = "Login"
        view.addSubview(loginLabel)
        
        loginLabel.font = UIFont.boldSystemFont(ofSize: 35)
        
        loginLabel.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(200)
            $0.trailing.equalTo(-100)
            $0.bottom.equalTo(-700)
            $0.leading.equalTo(170)
            
        }
    }
    
    func loginAndSignUpTextField() {
        
        idField.borderStyle = .none
        view.addSubview(idField)
        idField.attributedPlaceholder = NSAttributedString(string: "Id", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        idField.textColor = .black
        idField.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.bottom.equalTo(-500)
            $0.leading.equalTo(45)
        }
        
        passworldField.borderStyle = .none
        passworldField.attributedPlaceholder = NSAttributedString(string: "Passworld", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passworldField.textColor = .black
        view.addSubview(passworldField)
        passworldField.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.bottom.equalTo(-420)
            $0.leading.equalTo(45)
        }
    }
    
    func configureLoginButton() {
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
            $0.bottom.equalTo(-230)
            $0.leading.equalTo(45)
        }
        
        loginButton.addTarget(self, action: #selector(loginbuttonAction), for: .touchUpInside)
        
        }
    
    @objc func loginbuttonAction(sender: UIButton!){
        print(" 로그인 버튼 실행됨")
        postLogin()
    }
    
    func configureSignUpButton() {
        
        let signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.backgroundColor = .white
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        
        view.addSubview(signUpButton)
        
        signUpButton.snp.makeConstraints{
            $0.height.equalTo(55)
            $0.width.equalTo(325)
            $0.trailing.equalTo(-45)
            $0.bottom.equalTo(-170)
            $0.leading.equalTo(45)
        }
        
        signUpButton.addTarget(self, action: #selector(signUpButtonAction), for: .touchUpInside)
        
        }
    @objc func signUpButtonAction(sender: UIButton!){
        print(" 회원가입 버튼 실행됨")
        let goToMainTabBarVC = MainSignUpViewController()
        goToMainTabBarVC.modalPresentationStyle = .fullScreen
        self.present(goToMainTabBarVC, animated: true, completion: nil)
    }
    
    
    func postLogin() {
        
        let url = "http://44.209.75.36:8080/login"
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //post로 보낼 정보
        let params = ["user-id":idField.text!,
                      "password":passworldField.text!]
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).responseString() { (response) in
            switch response.response?.statusCode {
                
            case 200:
                debugPrint(response)
                if let userDate = try? JSONDecoder().decode(TokenModel.self, from: response.data!) {
                    KeyChain.create(key: Token.accessToken, token: userDate.access_token)
                    KeyChain.create(key: Token.refreshToken, token: userDate.resfresh_token)
                }
                    print("로그인 성공😁")
                    let goToMainTabBarVC = MainTabBarController()
                    goToMainTabBarVC.modalPresentationStyle = .fullScreen
                    self.present(goToMainTabBarVC, animated: true, completion: nil)
            default:
                debugPrint(response)
                if response.response?.statusCode != 200 {
                    print("로그인 실패")
                    let AlertMassge = UIAlertController(title: "경고", message: "로그인 실패", preferredStyle: UIAlertController.Style.alert)
                    let ActionMassge = UIAlertAction(title: "다시 작성해주세요", style: UIAlertAction.Style.default, handler: nil)
                    
                    AlertMassge.addAction(ActionMassge)
                    self.present(AlertMassge, animated: true, completion: nil)
            }
        }

    }

}
}


//view미리보기
import SwiftUI

struct LoginViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainLoginViewController {
        return MainLoginViewController()
    }
    
    func updateUIViewController(_ uiViewController: MainLoginViewController, context: Context) { }
    
    
    typealias UIViewControllerType = MainLoginViewController
}

@available(iOS 13.0.0, *)
struct LoginViewPreview: PreviewProvider {
    static var previews: some View {
        LoginViewControllerRepresentable()
    }
}

