//
//  MainSignUpViewController.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/13.
//

import UIKit

class MainSignUpViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        signUpText()
        nameViewLine()
        idViewLine()
        passworldViewLine()
        ageViewLine()
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
            $0.bottom.equalTo(-550)
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
            $0.bottom.equalTo(-500)
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
            $0.bottom.equalTo(-440)
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
            $0.bottom.equalTo(-380)
            $0.leading.equalTo(45)
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
