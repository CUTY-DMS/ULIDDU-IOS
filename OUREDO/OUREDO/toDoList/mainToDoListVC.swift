//
//  maintodoList.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/08.
//

import UIKit
import Alamofire
import FSCalendar

class ViewController: UIViewController,FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance{
    @IBOutlet var tableView: UITableView!
    @IBOutlet var calendarView: FSCalendar!
    @IBOutlet var editButton: UIButton!
    
    
    var doneButton : UIButton?
    var tasks = [Task]() {
        didSet {
            self.saveTasks()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.)
//        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTap))
//        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTap))
        self.tableView?.dataSource = self
        self.loadTasks()
        self.tableView?.delegate = self
        self.doneButtonTap()
        self.calendarView.delegate = self
//---------------------calendarView--------------------------
        calendarView?.scope = .month
        
        //날짜 값 한국어로 바꾸기
        calendarView?.calendarWeekdayView.weekdayLabels[0].text = "일"
        calendarView?.calendarWeekdayView.weekdayLabels[1].text = "월"
        calendarView?.calendarWeekdayView.weekdayLabels[2].text = "화"
        calendarView?.calendarWeekdayView.weekdayLabels[3].text = "수"
        calendarView?.calendarWeekdayView.weekdayLabels[4].text = "목"
        calendarView?.calendarWeekdayView.weekdayLabels[5].text = "금"
        calendarView?.calendarWeekdayView.weekdayLabels[6].text = "토"
        
        // 헤더의 날짜 포맷 설정
        calendarView?.appearance.headerDateFormat = "YYYY년 MM월"

        // 헤더의 폰트 색상 설정
        calendarView?.appearance.headerTitleColor = .black

        //날짜 여러개 설정
        calendarView?.allowsMultipleSelection = false
        
        // 헤더의 폰트 정렬 설정
        // .center & .left & .justified & .natural & .right
        calendarView?.appearance.headerTitleAlignment = .center

        // 헤더 높이 설정
        calendarView?.headerHeight = 40
        
        //주말은 색깔 바꾸기
        calendarView?.appearance.titleWeekendColor = .red
        
        //헤더의 흐릿한 다음 원 또는 년 제거하기
        calendarView?.appearance.headerMinimumDissolvedAlpha = 0
        
        // 달력의 평일 날짜 색깔
        calendarView?.appearance.titleDefaultColor = .black
        func calendarStyle(){

        //언어 한국어로 변경
        calendarView?.locale = Locale(identifier: "ko_KR")
        calendarView?.headerHeight = 66 // YYYY년 M월 표시부 영역 높이
        calendarView?.weekdayHeight = 41 // 날짜 표시부 행의 높이
        calendarView?.appearance.headerMinimumDissolvedAlpha = 0.0 //헤더 좌,우측 흐릿한 글씨 삭제
        calendarView?.appearance.headerDateFormat = "YYYY년 M월" //날짜(헤더) 표시 형식
        calendarView?.appearance.headerTitleColor = .black //2021년 1월(헤더) 색
        calendarView?.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24) //타이틀 폰트 크기

        calendarView?.backgroundColor = .white // 배경색
        calendarView?.appearance.weekdayTextColor = .black //요일(월,화,수..) 글씨 색
        calendarView?.appearance.titleWeekendColor = .black //주말 날짜 색
        calendarView?.appearance.titleDefaultColor = .black //기본 날짜 색
        calendarView?.appearance.todayColor = .clear //Today에 표시되는 선택 전 동그라미 색
        calendarView?.appearance.todaySelectionColor = .none  //Today에 표시되는 선택 후 동그라미 색
        // Month 폰트 설정
        calendarView?.appearance.headerTitleFont = UIFont(name: "NotoSansCJKKR-Medium", size: 16)
                
        // day 폰트 설정
        calendarView?.appearance.titleFont = UIFont(name: "Roboto-Regular", size: 14)
//---------------------calendarView--------------------------
    }
}

    @objc func doneButtonTap() {
        self.doneButton = self.editButton
        self.tableView.setEditing(false, animated: true)
    }

    @IBAction func tapEditButton(_ sender: Any) {
        guard !self.tasks.isEmpty else { return }
        self.editButton = self.doneButton
        self.tableView.setEditing(true, animated: true)
        //editButton이 다시 원래로 돌아오지 않음
        
    }
    
    func editBtnLayout(isOn : Bool){
        switch isOn {
        case true:
            guard !self.tasks.isEmpty else { return }
            self.editButton = self.doneButton
            self.tableView.setEditing(true, animated: true)
        case false:
            doneButtonTap()
        }
    }
    //----------------------------
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let modalPresentView = self.storyboard?.instantiateViewController(identifier: "TestViewController") as? TestViewController else { return }
        
        // 날짜를 원하는 형식으로 저장하기 위한 방법입니다.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        modalPresentView.date = dateFormatter.string(from: date)

        self.present(modalPresentView, animated: true, completion: nil)
    }
    //----------------------------

    
    @IBAction func tapAddButton(_ sender: Any) {
        let alert = UIAlertController(title: "할 일 등록", message: nil, preferredStyle: .alert)
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
            guard let title = alert.textFields?[0].text else { return }
            guard let content = alert.textFields?[1].text else { return }
            let task = Task(title: title, content: content, done: false, ispublic: false)
            self?.tasks.append(task)
            self?.tableView.reloadData()
            
            let ispublic : Bool = false
            
            //button 클릭시 시간을 가져오기
            let formatter = DateFormatter()
            let date = Date()
            formatter.dateFormat = "yyyy-MM-dd"
            let nowDetaTime = formatter.string(from: date)
            print("지금 시간은 : \(nowDetaTime)")
            //post코드
//-----------------------------------------------------------------------------------------------------
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
    //userDefaults의 값 저장하기
    func saveTasks() {
        let date = self.tasks.map {
             [
                "title" : $0.title,
                "content" : $0.content,
                "done" : $0.done,
                "ispubic" : $0.ispublic
             ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(date, forKey: "tasks")
    }
    //userDefaults 값 불러오기
    func loadTasks() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "tasks") as? [[String : Any]] else { return }
        self.tasks = data.compactMap {
            guard let title = $0["title"] as? String else { return nil }
            guard let content = $0["content"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil }
            guard let ispublic = $0["ispubic"] as? Bool else { return nil }
            return Task(title: title, content: content, done: done, ispublic: ispublic)
        }
    }
}

extension ViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = self.tasks[indexPath.row]
        cell.textLabel?.text = task.title
        cell.detailTextLabel?.text = task.content
        
        if task.done{
            cell.accessoryType = .detailButton
            //이벤트 구현
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
        //indexpath.row 저장
        //checkVC 로 보냄
        UserDefaults.standard.set(indexPath.row, forKey: "index")
        self.performSegue(withIdentifier: "goTocheckVC", sender: self)
    }

    //삭제 구현
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        self.tasks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        if self.tasks.isEmpty {
            self.doneButtonTap()
        }
    }
    //정렬 구현
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var tasks = self.tasks
        let task = tasks[sourceIndexPath.row]
        tasks.remove(at: sourceIndexPath.row)
        tasks.insert(task, at: destinationIndexPath.row)
        self.tasks = tasks
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var task = self.tasks[indexPath.row]
        task.done = !task.done
        self.tasks[indexPath.row] = task
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
//----------------------------------------------------
        
//        // 헤더의 날짜 포맷 설정
//        calendarView.appearance.headerDateFormat = "YYYY년 MM월"
//
//        // 헤더의 폰트 색상 설정
//        calendarView.appearance.headerTitleColor = UIColor.link
//
//        // 헤더의 폰트 정렬 설정
//        // .center & .left & .justified & .natural & .right
//        calendarView.appearance.headerTitleAlignment = .left
//
//        // 헤더 높이 설정
//        calendarView.headerHeight = 45
//
//        // 헤더 양 옆(전달 & 다음 달) 글씨 투명도
//        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0


//-------------------------------------------------------------------------------------------
