//
//  mainLoginViewController.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/12.
//

import UIKit
import SnapKit

class MainLoginViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configureLoginButton()
        configureSignUpButton()
        loginViewLine()
        signUpViewLine()
        loginText()
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

