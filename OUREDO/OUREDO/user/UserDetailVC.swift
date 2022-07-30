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
        getUserList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getUserList()
    }
    
    var result : [resultsArr] = []
    
    func getUserList() {
      let url = "http://44.209.75.36:8080/user"
        var request = URLRequest(url: URL(string: url)!)
        let AT : String? = KeyChain.read(key: Token.accessToken)
        request.headers.update(name: "Authorization", value: "Bearer \(AT!)")
        
        AF.request(request).response { (response) in switch response.result {
            case .success:
                    debugPrint(response)
                    print("성공 😮")
                    if let data = try? JSONDecoder().decode([resultsArr].self, from: response.data!){
                        DispatchQueue.main.async {
                            self.result = data
                            print(data)
                        }
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
}
