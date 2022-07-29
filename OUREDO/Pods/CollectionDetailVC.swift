//
//  DiaryDetailVC.swift
//  Pods
//
//  Created by 박준하 on 2022/07/21.
//

import UIKit
import Alamofire

protocol CollectionDetailViewDelegate: AnyObject {
    func didSelectDelegate(indexPath: IndexPath)
}

class CollectionDetailVC: UIViewController {

    @IBOutlet var titleLable: UILabel!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var dateLable: UILabel!
    @IBOutlet var writerLable: UIButton!
    @IBOutlet var nameLable: UILabel!
    @IBOutlet var likeCountLable: UILabel!
    weak var delegate: CollectionDetailViewDelegate?
    
    private var taskList = [Task]() {
        didSet {
            self.saveTasks()
        }
    }
    var result : [ToDoDetail] = []
        
    var shareTitle: ShareTitle?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.loadDiaryList()
        self.takeLable()
        print("CollectionDetailVC")
//        getUserList()
    }
    
//    창이 뜨지 않음
//    private func getUserList() {
//        let url = "http://44.209.75.36:8080/todo/{id}"
//        let AT : String? = KeyChain.read(key: Token.accessToken)
//        var request = URLRequest(url: URL(string: url)!)
//        request.method = .get
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.headers.update(name: "Authorization", value: "Bearer \(AT!)")
//
//
//        AF.request(request).response { (response) in switch response.result {
//                case .success(_):
//                    debugPrint(response)
//                    print("여기까지 성공 ❤️")
//                    if let data = try? JSONDecoder().decode([ToDoDetail].self, from: response.data!){
//                        DispatchQueue.main.async {
//                            self.result = data
//                            print(data)
//                        }
//                    }
//                case .failure(let error):
//                    print(error)
//                }
//        }
//    }
        
    private func configureView() {
        guard let shareDetail = self.shareTitle else { return }
        self.titleLable.text = shareDetail.title
        self.contentsTextView.text = shareDetail.contents
        self.dateLable.text = self.dateToString(date: shareDetail.date)
        }
                                                    
    private func dateToString(date: Date) -> String {
      let formatter = DateFormatter()
      formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
      formatter.locale = Locale(identifier: "ko_KR")
      return formatter.string(from: date)
    }
    
    //userDefaults의 값 저장하기
    func saveTasks() {
        let date = self.taskList.map {
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
    
    private func loadDiaryList() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "tasks") as? [[String: Any]] else { return }
        self.taskList = data.compactMap {
            guard let title = $0["title"] as? String else { return nil }
            guard let content = $0["content"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil }
            guard let ispublic = $0["ispubic"] as? Bool else { return nil }
            return Task(title: title, content: content, done: done, ispublic: ispublic)
        }
    }
    private func takeLable() {
        let index = UserDefaults.standard.integer(forKey: "index")
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        let nowDetaTime = formatter.string(from: Date())
        titleLable.text = taskList[index].title
        contentsTextView!.text = taskList[index].content
        dateLable.text = nowDetaTime
    }
}

