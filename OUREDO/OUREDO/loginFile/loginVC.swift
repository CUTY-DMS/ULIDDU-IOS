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
    @IBOutlet weak var userPassword: UITextField!
    
    var httpClient = HTTPClient()
    
    var userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func postLogin() {
        let url = "http://43.200.97.218:8080/login"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // POST 로 보낼 정보
        let params = ["user-id":userId.text!,
                      "password":userPassword.text!]
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        
        AF.request(request).responseString() { (response) in
            switch response.result {
            case .success:
                debugPrint(response)
                if let data = try? JSONDecoder().decode(TokenModel.self, from: response.data!) {
                    KeyChain.create(key: Token.accessToken, token: data.access_token)
                    KeyChain.create(key: Token.refreshToken, token: data.resfresh_token)
                    print("로그인 성공😁")
                    if let removable = self.view.viewWithTag(102) {
                        removable.removeFromSuperview()
                        self.performSegue(withIdentifier: "goToSuccessVC", sender: self)
                    }
                } else { print("ㅗㅗㅗㅗㅗ") }
                print("🤑POST 성공")
                
                
            case .failure(let error):
                if response.response?.statusCode != 200 {
                    print("로그인 실패")
                    let loginFailLabel = UILabel(frame: CGRect(x: 95, y: 479, width: 279, height: 45))
                    loginFailLabel.text = "아이디나 비밀번호가 다릅니다."
                    loginFailLabel.textColor = UIColor.red
                    loginFailLabel.tag = 102
                    self.view.addSubview(loginFailLabel)
                    
                }
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
    
    func shakeTextField(textField: UITextField) -> Void{
        UIView.animate(withDuration: 0.2, animations: {
            textField.frame.origin.x -= 10
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                textField.frame.origin.x += 20
            }, completion: { _ in
                UIView.animate(withDuration: 0.2, animations: {
                    textField.frame.origin.x -= 10
                })
            })
        })
    }
    @objc func didEndOnExit(_ sender: UITextField) {
        if userId.isFirstResponder {
            userPassword.becomeFirstResponder()
        }
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        
//        guard let ID = userId.text, !ID.isEmpty else { return }
//        guard let password = userPassword.text, !password.isEmpty else { return }
//
        if(userId.text == "" && userPassword.text == "") {
            let checkAgainAction = UIAlertController(title: "입력을 안했네요 ^^", message: "다시 확인해주세요", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
//        } else if userModel.isValidId(validUserId: ID) == false {
//            shakeTextField(textField: userId)
//            let IDLabel = UILabel(frame: CGRect(x: 115, y: 293, width: 279, height: 45))
//            IDLabel.text = "id 형식을 확인해 주세요"
//            IDLabel.textColor = UIColor.red
//            IDLabel.tag = 100
//            self.view.addSubview(IDLabel)
//        } else if userModel.isValidPassword(validPassword: password) == false {
//            shakeTextField(textField: userPassword)
//            let passwordLabel = UILabel(frame: CGRect(x: 90, y: 363, width: 279, height: 45))
//            passwordLabel.text = "비밀번호 형식을 확인해 주세요"
//            passwordLabel.textColor = UIColor.red
//            passwordLabel.tag = 101
//            self.view.addSubview(passwordLabel)
        } else {
            print("---------")
            postLogin()
        }
    }
}
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
// -----------------------------------------------------
