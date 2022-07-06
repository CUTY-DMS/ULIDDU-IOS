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
        userPasssword.layer.cornerRadius = CGFloat(radius)
        signUpButton.layer.cornerRadius = CGFloat(15)
    }
    func postsignUp() {
            let url = "http://43.200.97.218:8080/register"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10
            // POST 로 보낼 정보
        let params = [
            "name": userName.text!,
            "age":userAge.text!,
            "user-id":userId.text!,
            "password":userPasssword.text!
                     ] as Dictionary
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        request.httpBody = jsonData

        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseString { (response) in
                print(response.result)
                switch response.result {
                case .success:
                    print(request.headers)
                    print(response.response?.headers)
                    self.navigationController?.popViewController(animated: true)
                    print("✅POST 성공✅")
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                    print(url)
                }
            }
        }
    func signup(userName: String, age: String, userType: String,userId: String,password: String) {
        httpClient.post(
            url: AuthAPI.signup.path(),
            params: ["name": userName,
                     "age": age,
                     "user-Id": userId,
                     "password": password],
            header: Header.tokenIsEmpty.header()
        ).responseData(completionHandler: { res in
            switch res.response?.statusCode {
            case 200:
                self.navigationController?.popViewController(animated: true)
                print("성공✅")
            default:
                print(res.response?.statusCode ?? 0)
                print("실패🤬")
            }
        })
    }
    @IBAction func signInPressButton(_ sender: UIButton) {
        postsignUp()
        print("------------------------------")
        print("Name : \(userName.text!)")
        print("Id : \(userId.text!)")
        print("Password : \(userPasssword.text!)")
        print("Age : \(userAge.text!)")
        print("------------------------------")
//        if(userName.text == "") {
//            let checkAgainAction = UIAlertController(title: "아이디를 확인해주세요", message: "다시 입력해주세요.", preferredStyle: .alert)
//            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
//            self.present(checkAgainAction, animated: true, completion: nil)
//        };if(userAge.text == "") {
//            let checkAgainAction = UIAlertController(title: "email를 확인해주세요", message: "다시 입력해주세요.", preferredStyle: .alert)
//            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
//            self.present(checkAgainAction, animated: true, completion: nil)
//        };if(userId.text == "") {
//            let checkAgainAction = UIAlertController(title: "전송된 코드를 입력해주세요.", message: "다시 입력해주세요.", preferredStyle: .alert)
//            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
//            self.present(checkAgainAction, animated: true, completion: nil)
//        };if(userPasssword.text == "") {
//            let checkAgainAction = UIAlertController(title: "패스워드를 확인해주세요", message: "다시 입력해주세요.", preferredStyle: .alert)
//            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
//            self.present(checkAgainAction, animated: true, completion: nil)
//        };
    }
}
