//
//  MainHomeViewController.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/12.
//

import UIKit
import SwiftUI
import SnapKit
import Alamofire

class MainHomeViewController : UITableViewController {
    
    var homeList = [Task]()
    var addButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //UINavigationBar 설정
        title = "임시 설정"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableviewSize()
        addButtonImage()
    }
    func tableviewSize() {
        //UITableView 설정
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.backgroundColor = .red
        
        tableView.register(HomeListCell.self, forCellReuseIdentifier: "HomeListCell")

        tableView.snp.makeConstraints{
            $0.height.equalTo(275)
            $0.width.equalTo(430)
            $0.trailing.equalTo(0)
            $0.top.equalTo(515)
            $0.leading.equalTo(0)
        }
    }
    func addButtonImage() {
        view.addSubview(addButton)
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.contentMode = .scaleToFill

        addButton.backgroundColor = .blue
        addButton.tintColor = .black
        addButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(40)
            $0.top.equalTo(475)
            $0.trailing.equalTo(0)
        }
        addButton.addTarget(self, action: #selector(toDoPostbuttonAction), for: .touchUpInside)
    }
    @objc func toDoPostbuttonAction(sender: UIButton!){
        print("버튼 클릭 ✅")
        addToDoPost()
    }
    
    func addToDoPost() {
        let alert = UIAlertController(title: "할 일 등록", message: nil, preferredStyle: .alert)
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
            guard let title = alert.textFields?[0].text else { return }
            guard let content = alert.textFields?[1].text else { return }
            let task = Task(image: "ULIDDL-Logo", title: title, content: content, done: false, ispublic: false)
            self?.homeList.append(task)
            self?.tableView.reloadData()
            
            let ispublic : Bool = false
            
            //button 클릭시 시간을 가져오기
            let formatter = DateFormatter()
            let date = Date()
            formatter.dateFormat = "yyyy-MM-dd"
            let nowDetaTime = formatter.string(from: date)
            print("지금 시간은 : \(nowDetaTime)")
            //post코드
//----------------------------------------------------------------------------------------------
            let AT : String? = KeyChain.read(key: Token.accessToken)
            let RT : String? = KeyChain.read(key: Token.refreshToken)
            let url = "http://44.209.75.36:8080/todo"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10
            var header = HTTPHeaders()
            header.add(name: "Authorization", value: "Bearer \(AT!)")
            header.add(name: "X-Refresh-Token", value: RT!)
                                
            // POST 로 보낼 정보
        let params = [
            "title": title,
            "content": content,
            "ispublic" : ispublic,
            "todo-date": nowDetaTime
            ] as Dictionary
            
            print(title)
            print(content)
            print(nowDetaTime)
            
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        request.httpBody = jsonData

        AF.request(url,method: .post,parameters: params, encoding: JSONEncoding.default, headers: header)
            .responseString { (response) in
                switch response.response?.statusCode {
                case 200:
                    debugPrint(response)
                    self?.navigationController?.popViewController(animated: true)
                    print("✅add ToDo POST 성공✅")
                case 201:
                    debugPrint(response)
                    self?.navigationController?.popViewController(animated: true)
                    print("✅add ToDo POST 성공✅")
                default:
                    print("🤯post 성공하지 못했습니다🤬")
                    debugPrint(response)
                    debugPrint(params)
                }
            }
        })
//-------------------------------------------------------------
        let cancelButton = UIAlertAction(title: "취소", style: .default, handler: nil)
        alert.addAction(registerButton)
        alert.addAction(cancelButton)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "제목을 입력해 주세요"
        })
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "할 일을 입력해주세요"
        })
        self.present(alert, animated: true, completion: nil)
    }
    
}

//UITableView, DataSource, Delegate
extension MainHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeListCell", for: indexPath) as? HomeListCell else { return UITableViewCell() }
        let mainList = homeList[indexPath.row]
        cell.configure(whih: mainList)
        cell.textLabel?.text = mainList.title
        cell.detailTextLabel?.text = mainList.content
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHomeList = homeList[indexPath.row]
        let detailViewController = HomeDetilViewController()
        detailViewController.task = selectedHomeList
        self.show(detailViewController, sender: nil)
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var homeLists = self.homeList
        let task = homeLists[sourceIndexPath.row]
        homeLists.remove(at: sourceIndexPath.row)
        homeLists.insert(task, at: destinationIndexPath.row)
        self.homeList = homeLists
    }
    
}

import SwiftUI

struct MainHomeViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainHomeViewController {
        return MainHomeViewController()
    }
    
    func updateUIViewController(_ uiViewController: MainHomeViewController, context: Context) { }
    
    
    typealias UIViewControllerType = MainHomeViewController
}

@available(iOS 13.0.0, *)
struct MainHomeViewPreview: PreviewProvider {
    static var previews: some View {
        MainHomeViewControllerRepresentable()
    }
}

