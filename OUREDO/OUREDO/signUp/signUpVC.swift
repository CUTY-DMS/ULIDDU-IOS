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
            let url = "http://44.209.75.36:8080/register"
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
                case 204:
                    self.navigationController?.popViewController(animated: true)
                    print("😆POST 성공😆")
                    
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
    }
}
