//
//  MainSignUpViewController.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/13.
//

import UIKit

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
