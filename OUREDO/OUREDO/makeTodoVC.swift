//
//  makeTodo.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/01.
//

import UIKit
import Alamofire

class makeTodo : UIViewController {
    
    @IBOutlet weak var textTitle: UITextField!
    
    @IBOutlet weak var textContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTodo()
        print("todo를 추가하러 오셨군요!!")
    }
    
    func addTodo() {
        let url = "http://192.168.107.253:8080/api/auth"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10

        // POST 로 보낼 정보
    let params = ["title" : textTitle.text!,"content" : textContent.text!,
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
    
    @IBAction func addTodoButton(_ sender: Any) {
        
        print("정상적으로 전달되었습니다")
        addTodo()
        
    }
}
