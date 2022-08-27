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

class MainHomeViewController : UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    var addButton = UIButton()
    var correctionButton = UIButton()
    let tableView = UITableView()
    
    let refresh = UIRefreshControl()
    
    var getMyTodo: [GetToDoList] = []
    var addMyTodo: [Task] = []
    
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
        
        calendar?.scope = .month
        
        //날짜 값 한국어로 바꾸기
        calendar?.calendarWeekdayView.weekdayLabels[0].text = "일"
        calendar?.calendarWeekdayView.weekdayLabels[1].text = "월"
        calendar?.calendarWeekdayView.weekdayLabels[2].text = "화"
        calendar?.calendarWeekdayView.weekdayLabels[3].text = "수"
        calendar?.calendarWeekdayView.weekdayLabels[4].text = "목"
        calendar?.calendarWeekdayView.weekdayLabels[5].text = "금"
        calendar?.calendarWeekdayView.weekdayLabels[6].text = "토"
        
        // 헤더의 날짜 포맷 설정
        calendar?.appearance.headerDateFormat = "YYYY년 MM월"

        // 헤더의 폰트 색상 설정
        calendar?.appearance.headerTitleColor = .black

        //날짜 여러개 설정
        calendar?.allowsMultipleSelection = false
        
        // 헤더의 폰트 정렬 설정
        // .center & .left & .justified & .natural & .right
        calendar?.appearance.headerTitleAlignment = .center

        // 헤더 높이 설정
        calendar?.headerHeight = 40
        
        //주말은 색깔 바꾸기
        calendar?.appearance.titleWeekendColor = .red
        
        //헤더의 흐릿한 다음 원 또는 년 제거하기
        calendar?.appearance.headerMinimumDissolvedAlpha = 0
        
        // 달력의 평일 날짜 색깔
        calendar?.appearance.titleDefaultColor = .black
        func calendarStyle(){

        //언어 한국어로 변경
            calendar?.locale = Locale(identifier: "ko_KR")
            calendar?.headerHeight = 66 // YYYY년 M월 표시부 영역 높이
            calendar?.weekdayHeight = 41 // 날짜 표시부 행의 높이
            calendar?.appearance.headerMinimumDissolvedAlpha = 0.0 //헤더 좌,우측 흐릿한 글씨 삭제
            calendar?.appearance.headerDateFormat = "YYYY년 M월" //날짜(헤더) 표시 형식
            calendar?.appearance.headerTitleColor = .black //2021년 1월(헤더) 색
            calendar?.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24) //타이틀 폰트 크기

            calendar?.backgroundColor = .white // 배경색
            calendar?.appearance.weekdayTextColor = .black //요일(월,화,수..) 글씨 색
            calendar?.appearance.titleWeekendColor = .black //주말 날짜 색
            calendar?.appearance.titleDefaultColor = .black //기본 날짜 색
            calendar?.appearance.todayColor = .clear //Today에 표시되는 선택 전 동그라미 색
            calendar?.appearance.todaySelectionColor = .none  //Today에 표시되는 선택 후 동그라미 색
        // Month 폰트 설정
            calendar?.appearance.headerTitleFont = UIFont(name: "NotoSansCJKKR-Medium", size: 16)
                
        // day 폰트 설정
            calendar?.appearance.titleFont = UIFont(name: "Roboto-Regular", size: 14)
    }
}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.initRefresh()
        doneButtonTop()
        getUserList()
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
    }
    
    
    func tableviewSize() {
        //UITableView 설정
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        
        tableView.register(HomeListCell.self, forCellReuseIdentifier: "HomeListCell")

        tableView.snp.makeConstraints{
            $0.height.equalTo(310)
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
        guard !self.getMyTodo.isEmpty else { return }
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
            let task = Task(image: "ULIDDL-Logo1", title: title, content: content, done: false, ispublic: false)
            self?.addMyTodo.append(task)
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
                    self!.initRefresh()
                    
                case 201:
                    debugPrint(response)
                    self?.navigationController?.popViewController(animated: true)
                    print("✅add ToDo POST 성공✅")
                    self!.initRefresh()
                default:
                    print("🤯post 성공하지 못했습니다🤬")
                    debugPrint(response)
                    debugPrint(params)
                }
            }
        })
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
        self.initRefresh()
    }
    
    private func getUserList() {
        
        let url = "http://44.209.75.36:8080/todos/list?todoYearMonth=2022-08"
        let AT : String? = KeyChain.read(key: Token.accessToken)
        let header : HTTPHeaders = [
            "Authorization" : "Bearer \(AT!)"
        ]
        
        print("")
        print("====================================")
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
                        print("===getMyToDo는 data의 값을 보유 하고 있습니다===")
                        self.tableView.reloadData()
                        self.initRefresh()
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
                    self.initRefresh()
                    
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
    func deleteList(id: Int) {
            let AT : String? = KeyChain.read(key: Token.accessToken)
            let RT : String? = KeyChain.read(key: Token.refreshToken)
        let url = "http://44.209.75.36:8080/todo/\(id)"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10
            var header = HTTPHeaders()
            header.add(name: "Authorization", value: "Bearer \(AT!)")
            header.add(name: "X-Refresh-Token", value: RT!)


        AF.request(url,method: .delete, encoding: JSONEncoding.default, headers: header)
            .responseString { (response) in
                switch response.response?.statusCode {
                case 200:
                    debugPrint(response)
                    print("url 경로 : \(request.url as Any)")
                    print("🌹delete 성공🌹")
                case 204:
                    debugPrint(response)
                    print("url 경로 : \(request.url as Any)")
                    print("🌹delete 성공🌹")
                default:
                    print("🤯delete 성공하지 못했습니다🤬")
                    debugPrint(response)
            }
        }
    }
}


//UITableView, DataSource, Delegate
extension MainHomeViewController : UITableViewDataSource, UITableViewDelegate {
    
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
        
        //데이터를 받아오지 못함
        let selectedHomeList = getMyTodo[indexPath.row]
        let goToHomeDetilViewControllerVC = HomeDetilViewController()
        goToHomeDetilViewControllerVC.getTodoUser = selectedHomeList
        self.show(goToHomeDetilViewControllerVC, sender: nil)
        print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
        print(selectedHomeList)
        print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
    }
    
    //삭제 구현
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("🤝🤝🤝🤝🤝🤝🤝🤝🤝🤝🤝🤝")
        print(indexPath.row)
        print("🤝🤝🤝🤝🤝🤝🤝🤝🤝🤝🤝🤝")
        let test = getMyTodo[indexPath.row]
        deleteList(id: test.id)
        self.getMyTodo.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        if getMyTodo.isEmpty {
            self.doneButtonTop()
        }
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //cell 위치 변경
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var homeLists = self.getMyTodo
        let task = homeLists[sourceIndexPath.row]
        homeLists.remove(at: sourceIndexPath.row)
        homeLists.insert(task, at: destinationIndexPath.row)
        self.getMyTodo = homeLists
    }
    
}


//새로 고침
extension MainHomeViewController {
    
    func initRefresh() {
        refresh.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        refresh.backgroundColor = UIColor.clear
        self.tableView.refreshControl = refresh
    }
 
    @objc func refreshTable(refresh: UIRefreshControl) {
        print("새로고침")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.tableView.reloadData()
            self.getUserList()
            refresh.endRefreshing()
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y < -0.1) {
            self.refreshTable(refresh: self.refresh)
        }
    }
 
}
