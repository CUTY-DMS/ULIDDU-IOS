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
        print(KeyChain.read(key: Token.accessToken))
        print(KeyChain.read(key: Token.refreshToken))
    }
    func postLogin() {
        let url = "http://44.209.75.36:8080/login"
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
            switch response.response?.statusCode {
                
            case 200:
                debugPrint(response)
                if let userDate = try? JSONDecoder().decode(TokenModel.self, from: response.data!) {
                    KeyChain.create(key: Token.accessToken, token: userDate.access_token)
                    KeyChain.create(key: Token.refreshToken, token: userDate.resfresh_token)
                }
                    print("로그인 성공😁")
                    guard let login = self.storyboard?.instantiateViewController(identifier: "goToSuccessVC") else { return }
                    login.modalPresentationStyle = .fullScreen

                    self.present(login, animated: true, completion: nil)
                
            default:
                debugPrint(response)
                if response.response?.statusCode != 200 {
                    print("로그인 실패")
                    let AlertMassge = UIAlertController(title: "경고", message: "로그인 실패", preferredStyle: UIAlertController.Style.alert)
                    let ActionMassge = UIAlertAction(title: "다시 작성해주세요", style: UIAlertAction.Style.default, handler: nil)
                    
                    AlertMassge.addAction(ActionMassge)
                    self.present(AlertMassge, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func LoginButton(_ sender: Any) {

        if(userId.text == "" && userPassword.text == "") {
            let checkAgainAction = UIAlertController(title: "입력을 안했네요 ^^", message: "다시 확인해주세요", preferredStyle: .alert)
            checkAgainAction.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(checkAgainAction, animated: true, completion: nil)

        } else {
            print("---------")
            postLogin()
        }
    }
}
