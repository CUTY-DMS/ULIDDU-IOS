//
//  PublicFeedViewController.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/12.
//

import UIKit
import Alamofire

class PublicFeedViewController : UIViewController {
    
    var getMyTodo: [GetToDoList] = []
    let tableView = UITableView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableviewSize()
        getUserToDoList()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableviewSize() {
        //UITableView 설정
        view.addSubview(tableView)
        tableView.backgroundColor = .black
        
        tableView.register(HomeListCell.self, forCellReuseIdentifier: "HomeListCell")

        tableView.snp.makeConstraints{
            $0.height.equalTo(275)
            $0.width.equalTo(430)
            $0.trailing.equalTo(0)
            $0.top.equalTo(515)
            $0.leading.equalTo(0)
        }

    }
    
    
    private func getUserToDoList() {
        
        let url = "http://44.209.75.36:8080/todo/list/user/{id}"
        let AT : String? = KeyChain.read(key: Token.accessToken)
        let header : HTTPHeaders = [
            "Authorization" : "Bearer \(AT!)"
        ]
        
        print("")
        print("====================================")
        print("-------------------------------")
        print("주 소 :: ", url)
        print("====================================")
        print("")
        
        AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let res):
                    
                    do {
                        let data = try JSONDecoder().decode([GetToDoList].self, from: response.data!)
                        print(data)
                        self.getMyTodo = data
                        self.tableView.reloadData()
                    } catch {
                        print(error)
                    }
                    
                    print("")
                    print("-------------------------------")
                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
                    print("-------------------------------")
                    print("응답 데이터 :: ", String(data: res, encoding: .utf8) ?? "")
                    print("====================================")
                    debugPrint(response)
                    print("-------------------------------")
                    print("")
                    
                case .failure(let err):
                    print("")
                    print("-------------------------------")
                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
                    print("-------------------------------")
                    print("에 러 :: ", err.localizedDescription)
                    print("====================================")
                    debugPrint(response)
                    print("")
                    break
                }
            }
    }
    
}


//UITableView, DataSource, Delegate
extension PublicFeedViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getMyTodo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeListCell", for: indexPath) as? HomeListCell else { return UITableViewCell() }
        
//        let mainList = self.getMyTodo[indexPath.row]
        
        cell.configure()
        
        
        cell.titleLable.text = "\(getMyTodo[indexPath.row].title)"
        cell.contentLable.text = "\(getMyTodo[indexPath.row].todoDate)"
        //configure에서 설정
        //        cell.textLabel?.text = mainList.title
        //        cell.detailTextLabel?.text = mainList.content
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailViewController = HomeDetilViewController()
//        detailViewController.task = selectedHomeList
//        self.show(detailViewController, sender: nil)
        
        //데이터를 받아오지 못함
        
//        let selectedHomeList = getMyTodo[indexPath.row]
//        let goToHomeDetilViewControllerVC = HomeDetilViewController()
//        self.show(goToHomeDetilViewControllerVC, sender: nibName)
    }
}
