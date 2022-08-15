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
import FSCalendar

class MainHomeViewController : UIViewController {
    
    var homeList = [Task]()
    var addButton = UIButton()
    var correctionButton = UIButton()
    let tableView = UITableView()
    
    @objc var doneButton : UIButton!

    
    fileprivate weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        //UINavigationBar 설정
        title = "임시 설정"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableviewSize()
        addButtonImage()
        calendarVeiwSet()
        correctionButtonSet()
        getMyToDoList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        doneButtonTop()
    }
    
    func calendarVeiwSet() {
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar
        
        calendar.snp.makeConstraints {
            $0.height.equalTo(355)
            $0.width.equalTo(375)
            $0.top.equalTo(90)
            $0.trailing.equalTo(0)
            $0.leading.equalTo(0)
        }
        
        //calendatView 설정
        
        
    }
    
    
    func tableviewSize() {
        //UITableView 설정
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        
        tableView.register(HomeListCell.self, forCellReuseIdentifier: "HomeListCell")

        tableView.snp.makeConstraints{
            $0.height.equalTo(275)
            $0.width.equalTo(430)
            $0.trailing.equalTo(0)
            $0.top.equalTo(515)
            $0.leading.equalTo(0)
        }

    }
    
    func correctionButtonSet() {
        view.addSubview(correctionButton)
        correctionButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        correctionButton.contentMode = .scaleToFill
        
        correctionButton.backgroundColor = .white
        correctionButton.tintColor = .black
        correctionButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(40)
            $0.top.equalTo(475)
            $0.leading.equalTo(0)
        }
        correctionButton.addTarget(self, action: #selector(correctionbuttonAction), for: .touchUpInside)
//        correctionButton.addTarget(self, action: #selector(correctionbuttonActionBack), for: .touchUpOutside)
    }
//
//    @objc func correctionbuttonActionBack(sender: UIButton!){
//        doneButtonTop()
//    }
//
    @objc func correctionbuttonAction(sender: UIButton!){
        print("버튼 클릭 ✅")
        guard !self.homeList.isEmpty else { return }
        self.tableView.setEditing(true, animated: true)
    }
    
    @objc func doneButtonTop() {
        self.doneButton = self.correctionButton
        self.tableView.setEditing(false, animated: true)
    }

    func addButtonImage() {
        view.addSubview(addButton)
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.contentMode = .scaleToFill

        addButton.backgroundColor = .white
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
    
    private func getMyToDoList() {
        
        let url = "http://44.209.75.36:8080/todo/list"
        let AT : String? = KeyChain.read(key: Token.accessToken)
        let header : HTTPHeaders = [
            "Authorization" : "Bearer \(AT!)"
        ]
        
        let formatter = DateFormatter()
        let date = Date()
        formatter.dateFormat = "yyyy-MM"
        let nowDetaTime = formatter.string(from: date)
        print("지금 시간은 : \(nowDetaTime)")
        
        let queryString = [
            "todo-year-month": nowDetaTime
        ]as Dictionary
        
        print("")
        print("====================================")
        print("-------------------------------")
        print("주 소 :: ", url)
        print("-------------------------------")
        print("데이터 :: ", queryString.description)
        print("====================================")
        print("")
        
        AF.request(url, method: .get, parameters: queryString, encoding: URLEncoding.queryString, headers: header).validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let res):
                    do {
                        print("")
                        print("-------------------------------")
                        print("응답 코드 :: ", response.response?.statusCode ?? 0)
                        print("-------------------------------")
                        print("응답 데이터 :: ", String(data: res, encoding: .utf8) ?? "")
                        print("====================================")
                        print("")
                        }
                catch (let err){
                    print("")
                    print("-------------------------------")
                    print("catch :: ", err.localizedDescription)
                    print("====================================")
                    print("")
                        }
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
extension MainHomeViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeListCell", for: indexPath) as? HomeListCell else { return UITableViewCell() }
        let mainList = homeList[indexPath.row]
        cell.configure(whih: mainList)
        //configure에서 설정
//        cell.textLabel?.text = mainList.title
//        cell.detailTextLabel?.text = mainList.content
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHomeList = homeList[indexPath.row]
        let detailViewController = HomeDetilViewController()
        detailViewController.task = selectedHomeList
        self.show(detailViewController, sender: nil)
    }
    
    //삭제 구현
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        self.homeList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        if self.homeList.isEmpty {
            self.doneButtonTop()
        }
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var homeLists = self.homeList
        let task = homeLists[sourceIndexPath.row]
        homeLists.remove(at: sourceIndexPath.row)
        homeLists.insert(task, at: destinationIndexPath.row)
        self.homeList = homeLists
    }
    
}

extension MainHomeViewController : FSCalendarDelegate, FSCalendarDataSource {

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
