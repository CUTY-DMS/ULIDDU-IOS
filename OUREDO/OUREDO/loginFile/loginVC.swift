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
        
        postLogin()
    }
    
    func loginCheck(userId: String, password: String) -> Bool {
        for user in userModel.users {
            if user.USERID == userId && user.PASSWORD == password {
                print("로그인 성공하셨습니다")
                return true // 로그인 성공
            }
        }
        print("로그인 정보가 잘못되었습니다")
        return false
    }
    
    func postLogin() {
            let url = "http://43.200.97.218:8080/login"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10

            // POST 로 보낼 정보
        let params = ["Id":userId.text!,"pw":userPassword.text!
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
                    print(url)
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
        }
    func loginUp(userId: String, password: String) {
        httpClient.post(
            url: AuthAPI.lagin.path(),
            params: ["userId": userId, "password": password],
            header: Header.tokenIsEmpty.header()
        ).responseData(completionHandler: { res in
            switch res.response?.statusCode {
            case 200:
                self.navigationController?.popViewController(animated: true)
                print("loginUp성공✅")
            default:
                print(res.response?.statusCode ?? 0)
                print("loginUp실패🤬")
            }
        })
    }
    func seelogin(userId: String, password: String) {
        httpClient.get(
            url: AuthAPI.lagin.path(),
            params: ["userId" : userId],
            header: Header.tokenIsEmpty.header()).responseData(completionHandler: { res in
            switch res.response?.statusCode {
            case 200:
                self.navigationController?.popViewController(animated: true)
                print("seelogin성공✅")
            default:
                print(res.response?.statusCode ?? 0)
                print("실패🤬")
            }
        })
    }
    //TextField 흔들기 애니메이션
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
        postLogin()
        if(userId.text == "" && userPassword.text == ""){
            let checkAgainAction = UIAlertController(title: "입력을 하나도 안했네요 ^^", message: "다시 확인해주세요", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
        };
        if(userId.text == "") {
            let checkAgainAction = UIAlertController(title: "아이디를 확인해주세요", message: "다시 입력해주세요.", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
        };if(userPassword.text == "") {
            let checkAgainAction = UIAlertController(title: "password를 확인해주세요", message: "다시 입력해주세요.", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
        };
        // 옵셔널 바인딩 & 예외 처리 : Textfield가 빈문자열이 아니고, nil이 아닐 때
          guard let ID = userId.text, !ID.isEmpty else { return }
          guard let password = userPassword.text, !password.isEmpty else { return }
              
        
        if userModel.isValidId(validUserId: ID){
              if let removable = self.view.viewWithTag(100) {
                  removable.removeFromSuperview()
              }
        }
        else {
              shakeTextField(textField: userId)
              let IDLabel = UILabel(frame: CGRect(x: 68, y: 350, width: 279, height: 45))
              IDLabel.text = "id 형식을 확인해 주세요"
              IDLabel.textColor = UIColor.red
              IDLabel.tag = 100
              print(ID)

              self.view.addSubview(IDLabel)
          } // 이메일 형식 오류
        if userModel.isValidPassword(validPassword: password){
              if let removable = self.view.viewWithTag(101) {
                  removable.removeFromSuperview()
              }
          }
          else{
              shakeTextField(textField: userPassword)
              let passwordLabel = UILabel(frame: CGRect(x: 68, y: 435, width: 279, height: 45))
              passwordLabel.text = "비밀번호 형식을 확인해 주세요"
              passwordLabel.textColor = UIColor.red
              passwordLabel.tag = 101
              print(password)
              self.view.addSubview(passwordLabel)
          } // 비밀번호 형식 오류
          if userModel.isValidId(validUserId: ID) && userModel.isValidPassword(validPassword: password) {
              let loginSuccess: Bool = loginCheck(userId: ID, password: password)
              if loginSuccess {
                  print("로그인 성공")
                  if let removable = self.view.viewWithTag(102) {
                      removable.removeFromSuperview()
                  }
                  self.performSegue(withIdentifier: "goToSuccessVC", sender: self)
              }
          }
              else {
                  print("로그인 실패")
                  shakeTextField(textField: userId)
                  shakeTextField(textField: userPassword)
                  let loginFailLabel = UILabel(frame: CGRect(x: 68, y: 510, width: 279, height: 45))
                  loginFailLabel.text = "아이디나 비밀번호가 다릅니다."
                  loginFailLabel.textColor = UIColor.red
                  loginFailLabel.tag = 102
                      
                  self.view.addSubview(loginFailLabel)
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
