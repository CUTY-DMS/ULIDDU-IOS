//
//  signUpVC.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/01.
//

import UIKit
import Alamofire

class signUp: UIViewController {

    @IBOutlet var userName: UITextField!
    
    @IBOutlet var userPasssword: UITextField!
    
    @IBOutlet var signUpButton: UIButton!
    
    @IBOutlet weak var userAge: UITextField!
    
    @IBOutlet weak var userId: UITextField!
    
    var httpClient = HTTPClient()
    
    var radius = 22
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userName.layer.cornerRadius = CGFloat(radius)
        userPasssword.layer.cornerRadius =
        CGFloat(radius)
        signUpButton.layer.cornerRadius =
        CGFloat(15)
        postsignUp()
    }
    func postsignUp() {
            let url = "http://192.168.107.253:8080/api/auth"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10

            // POST 로 보낼 정보
        let params = ["name": userName.text!,"email":userAge.text!,               "emailCheckCode":userId.text!,"pw":userPasssword.text!,
                      "userType": "USER"
                     ] as Dictionary

            // httpBody 에 parameters 추가
            do {
                try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                print("http Body Error")
            }

            AF.request(request).responseString { (response) in
                switch response.result {
                case .success:
                    print("url 경로 : \(request.url as Any)")
                    print("✅POST 성공✅")
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
        }
    func signup(email: String, password: String, nickName: String,emailCheckCode: String,userType: String) {
        httpClient.post(
            url: AuthAPI.signup.path(),
            params: ["email": email, "emailCheckCode": emailCheckCode, "pw": password, "name": nickName, "userType": userType],
            header: Header.tokenIsEmpty.header()
        ).responseData(completionHandler: { res in
            switch res.response?.statusCode {
            case 200:
                self.navigationController?.popViewController(animated: true)
            default:
                print(res.response?.statusCode ?? 0)
            }
        })
    }
    
//    @IBAction func SendVerificationCodeButton(_ sender: UIButton) {
//        httpClient.post(
//            url: AuthAPI.emailcheck.path() + "?email="+userAge.text!,
//            params: nil,
//            header:Header.tokenIsEmpty.header()
//        ).responseData(completionHandler: {res in
//            switch res.response?.statusCode {
//            case 200:
//                sender.titleLabel?.text! = "인증번호 확인"
//            default:
//                print(res.response?.statusCode ?? 0)
//            }
//        })
//    }
    @IBAction func signInPressButton(_ sender: UIButton) {
        postsignUp()
        if(userName.text == "") {
            let checkAgainAction = UIAlertController(title: "아이디를 확인해주세요", message: "다시 입력해주세요.", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
        };if(userAge.text == "") {
            let checkAgainAction = UIAlertController(title: "email를 확인해주세요", message: "다시 입력해주세요.", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
        };if(userId.text == "") {
            let checkAgainAction = UIAlertController(title: "전송된 코드를 입력해주세요.", message: "다시 입력해주세요.", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
        };if(userPasssword.text == "") {
            let checkAgainAction = UIAlertController(title: "패스워드를 확인해주세요", message: "다시 입력해주세요.", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)
        };
    }
}
