//
//  userDetailVC.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/29.
//

import UIKit
import Alamofire

class userDetailViewController : UIViewController {
    
    @IBOutlet var userName : UILabel!
    @IBOutlet var userId : UILabel!
    @IBOutlet var userAge : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    var result : [resultsArr] = []
    
    func getUserList(
      completionHandler: @escaping (Result<resultsArr, Error>) -> Void
    ) {
      let url = "http://44.209.75.36:8080/user"
        var request = URLRequest(url: URL(string: url)!)
        let AT : String? = KeyChain.read(key: Token.accessToken)
        request.headers.update(name: "Authorization", value: "Bearer \(AT!)")
        
        AF.request(url, method: .get)
        .responseData(completionHandler: { response in
          switch response.result {
          case let .success(data):
            do {
                print("😀")
              let decoder = JSONDecoder()
              let result = try decoder.decode(resultsArr.self, from: data)
              completionHandler(.success(result))
            } catch {
              completionHandler(.failure(error))
            }
          case let .failure(error):
            completionHandler(.failure(error))
            }
            })
        }
    }
}
