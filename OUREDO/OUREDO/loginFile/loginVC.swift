//
//  loginVC.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/01.
//

import UIKit
import Alamofire

class loginVC: UIViewController {
    
    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postLogin()
    }
    func postLogin() {
            let url = "http://43.200.97.218:8080"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10

            // POST 로 보낼 정보
        let params = ["Id":userId.text!,"pw":password.text!
                     ] as Dictionary

            // httpBody 에 parameters 추가
            do {
                try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                print("🤬http Body Error")
            }

            AF.request(request).responseString { (response) in
                switch response.result {
                case .success:
                    print("🤑POST 성공")
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
        }
    @IBAction func LoginButton(_ sender: Any) {
        postLogin()
        if(userId.text == "" && password.text == ""){
            let checkAgainAction = UIAlertController(title: "입력을 하나도 안했네요 ^^", message: "다시 확인해주세요", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
        };
        if(userId.text == "") {
            let checkAgainAction = UIAlertController(title: "아이디를 확인해주세요", message: "다시 입력해주세요.", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
        };if(password.text == "") {
            let checkAgainAction = UIAlertController(title: "password를 확인해주세요", message: "다시 입력해주세요.", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
        };
  ////로그인 정보가 맞을때만 작동하는 거 만들기
//------------------------------------------------------
        
//        if(userName.text != "" && password.text != ""){
//            let checkAgainAction = UIAlertController(title: "gmail과 password를 확인해주세요", message: "다시 확인해주세요", preferredStyle: .alert)
//            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
//            self.present(checkAgainAction, animated: true, completion: nil)
//        };
//        if(userName.text != "") {
//            let checkAgainAction = UIAlertController(title: "gmail를 확인해주세요", message: "gamil가 틀렸습니다.", preferredStyle: .alert)
//            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
//            self.present(checkAgainAction, animated: true, completion: nil)
//        };if(password.text != "") {
//            let checkAgainAction = UIAlertController(title: "비밀번호를 확인해주세요", message: "비밀번호를 다시 입력해주세요.", preferredStyle: .alert)
//            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
//            self.present(checkAgainAction, animated: true, completion: nil)
//        };
//    }
// ------------------------------------------------------
    }
}
