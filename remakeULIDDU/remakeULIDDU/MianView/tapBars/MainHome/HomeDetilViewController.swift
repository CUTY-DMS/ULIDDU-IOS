//
//  HomeDetilViewController.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/14.
//

import UIKit
import Alamofire

class HomeDetilViewController : UITableViewController {
    var task = DetailView()
    
    var getDetilToDo: [DetailView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = task.title
        
        
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HomeDetailListCell")
        tableView.rowHeight = UITableView.automaticDimension
        
        //디테일뷰의 이미지 크기
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        let headerView = UIImageView(frame: frame)
        
        
        headerView.contentMode = .scaleAspectFit
        headerView.image = UIImage(named: "ULIDDL-Logo")

        
        tableView.tableHeaderView = headerView
    }
    
    private func detailMyToDoList() {
        
        let url = "http://44.209.75.36:8080/todo/{id}"
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
                        let data = try JSONDecoder().decode([DetailView].self, from: response.data!)
                        print(data)
                        self.getDetilToDo = data
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

//UITableView delegate dataSource
extension HomeDetilViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "id"
        case 1:
            return "제목"
        case 2:
            return "내용"
        case 3:
            return "작성자"
        case 4:
            return "작성 날짜"
        case 5:
            return "수정 날짜"
        case 6:
            return "성공 여부"
        case 7:
            return "공개 여부"
        case 8:
            return "좋아요 여부"
        case 9:
            return "좋아요 개수"
        default:
            return nil
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "HomeDetailListCell")
        
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        
        detailMyToDoList()
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "\(task.id)"
            return cell
        case 1:
            cell.textLabel?.text = "\(task.title)"
            return cell
        case 2:
            cell.textLabel?.text = "\(task.content)" //타입 변환 해야함
            return cell
        case 3:
            cell.textLabel?.text = "\(task.writer)" //타입 변환 해야함
            return cell
        case 4:
            cell.textLabel?.text = "\(task.todoDate)"
            return cell
        case 5:
            cell.textLabel?.text = "\(task.completedDate)"
            return cell
        case 6:
            cell.textLabel?.text = "\(task.iscompleted)" //타입 변환 해야함
            return cell
        case 7:
            cell.textLabel?.text = "\(task.ispublic)" //타입 변환 해야함
            return cell
        case 8:
            cell.textLabel?.text = "\(task.isliked)" //타입 변환 해야함
            return cell
        case 9:
            cell.textLabel?.text = "\(task.likeCount)" //타입 변환 해야함
            return cell
        default:
            return cell
        }
    }
}
