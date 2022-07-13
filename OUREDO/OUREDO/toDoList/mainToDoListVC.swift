//
//  maintodoList.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/08.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
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
        self.tableView.dataSource = self
        self.loadTasks()
        self.tableView.delegate = self
    }

    @objc func doneButtonTap() {
        self.doneButton = self.editButton
        self.tableView.setEditing(false, animated: true)
    }

    @IBAction func tapEditButton(_ sender: Any) {
        guard !self.tasks.isEmpty else { return }
        self.editButton = self.doneButton
        self.tableView.setEditing(true, animated: true)
    }
    
    
    @IBAction func tapAddButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "할 일 등록", message: nil, preferredStyle: .alert)
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
            guard let title = alert.textFields?[0].text else { return }
            guard let content = alert.textFields?[1].text else { return }
            let task = Task(title: title, content: content, done: false)
            self?.tasks.append(task)
            self?.tableView.reloadData()
            
            //button 클릭시 시간을 가져오기
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let nowDetaTime = formatter.string(from: Date())
            print("지금 시간은 : \(nowDetaTime)\n")
            //post코드
//-----------------------------------------------------------------------------------------------------
            let AT : String? = KeyChain.read(key: Token.accessToken)
//            let RT : String? = KeyChain.read(key: Token.refreshToken)
            let url = "http://43.200.97.218:8080/todo"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10
            var header = HTTPHeaders()
            header.add(name: "Authorization", value: "Bearer \(AT!)")
            
            // POST 로 보낼 정보
        let params = [
            "title": title,
            "content": content,
            "todo-date": nowDetaTime
                     ] as Dictionary
        
            print(title)
            print(content)
            print(nowDetaTime)
            
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        request.httpBody = jsonData

        AF.request(url,method: .post,parameters: params, encoding: JSONEncoding.default)
            .responseString { (response) in
            debugPrint(response)
                switch response.response?.statusCode {
                case 200:
                    self?.navigationController?.popViewController(animated: true)
                    print("✅POST 성공✅")
                default:
                    print("hi error")
                }
            }
        })
//-----------------------------------------------------------------------------------------------------
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
                "done" : $0.done
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
            return Task(title: title, content: content, done: done)
        }
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = self.tasks[indexPath.row]
        cell.textLabel?.text = task.title
        cell.detailTextLabel?.text = task.content
        //checkmark
        if task.done{
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
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
