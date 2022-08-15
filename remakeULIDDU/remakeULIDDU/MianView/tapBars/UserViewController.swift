//
//  UserViewController.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/12.
//

import UIKit

class UserViewController : UIViewController {
    
    let profileView = UIView()
    let nameLabel = UILabel()
    let DetailButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        profileSet()
        nameLabelSet()
        configureDetailButton()
        lineView()
    }
    
    func profileSet() {

        view.addSubview(profileView)
        profileView.backgroundColor = .black
        profileView.layer.cornerRadius = 50
        
        profileView.snp.makeConstraints{
            $0.height.equalTo(100)
            $0.width.equalTo(100)
            $0.trailing.equalTo(-300)
            $0.top.equalTo(160)
            $0.leading.equalTo(30)
        }
    }
    
    func lineView() {
        let signUpLine = UIView()
        view.addSubview(signUpLine)
        signUpLine.backgroundColor = .black
        signUpLine.snp.makeConstraints{
            $0.height.equalTo(10)
            $0.width.equalTo(325)
            $0.trailing.equalTo(0)
            $0.top.equalTo(310)
            $0.leading.equalTo(0)
        }
    }
    
    func nameLabelSet() {
        view.addSubview(nameLabel)
        
        nameLabel.textColor = .black
        nameLabel.text = "박준하"
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        nameLabel.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(40)
            $0.trailing.equalTo(-100)
            $0.top.equalTo(185)
            $0.leading.equalTo(160)
        }
    }
    
    func configureDetailButton() {
        DetailButton.setTitle("상세보기", for: .normal)
        DetailButton.backgroundColor = .black
        
        view.addSubview(DetailButton)
        
        DetailButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        DetailButton.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.width.equalTo(115)
            $0.trailing.equalTo(-120)
            $0.top.equalTo(225)
            $0.leading.equalTo(160)
        }
        DetailButton.addTarget(self, action: #selector(DetailButtonAction), for: .touchUpInside)
    }
    @objc func DetailButtonAction(sender: UIButton!){
        print(" 상세보기 버튼 실행됨")
    }
}



//view미리보기
import SwiftUI

struct UserViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UserViewController {
        return UserViewController()
    }
    
    func updateUIViewController(_ uiViewController: UserViewController, context: Context) { }
    
    
    typealias UIViewControllerType = UserViewController
}

@available(iOS 13.0.0, *)
struct UserViewPreview: PreviewProvider {
    static var previews: some View {
        UserViewControllerRepresentable()
    }
}
