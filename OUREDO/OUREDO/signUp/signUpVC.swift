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
        print(url)
        let params = [
            "name": userName.text!,
            "age":userAge.text!,
            "user-id":userId.text!,
            "password":userPasssword.text!
                     ] as Dictionary
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        request.httpBody = jsonData

        AF.request(url,method: .post,parameters: params, encoding: JSONEncoding.default)
            .responseString { (response) in
            debugPrint(response)
                
                switch response.response?.statusCode {
                case 200:
                    self.navigationController?.popViewController(animated: true)
                    print("✅POST 성공✅")
//------------------------------------------------------------------------------------------
                    //userDefaults 값 저장
                    func saveUser() {
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(params, forKey: "signUp")
                    }
                    //userDefaults 값 불러오기
                    func loadUser() {
                        let check = UserDefaults.standard.string(forKey: "signUp")
                    }
//------------------------------------------------------------------------------------------
                default:
                    print("hi error")
                }
            }
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
//  보류
    }
}
