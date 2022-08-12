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
        let textView = UITextView()
        view.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        configureTestButton()
    }
    
    func configureTestButton() {
        let testButton = UIButton()
        testButton.setTitle("로그인!", for: .normal)
        testButton.backgroundColor = .red
        testButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(testButton)
        
        let safeArea = view.safeAreaLayoutGuide
        
        testButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20).isActive = true
        
        testButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20).isActive = true
        
        testButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
        
        testButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        }
    @objc func buttonAction(sender: UIButton!){
        print("버튼 실행됨")
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

