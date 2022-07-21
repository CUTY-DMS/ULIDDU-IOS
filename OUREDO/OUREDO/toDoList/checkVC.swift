//
//  checkVC.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/21.
//

import UIKit

class checkViewController : UIViewController {
    
    
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var contentsLable: UITextView!
    @IBOutlet var dateLable: UILabel!
    
    var index: Int = 0
    
    private var diaryList = [Task]() {
        didSet {
            self.saveTasks()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDiaryList()
        self.takeLable()
        print("안녕")
    }
    
    
    func saveTasks() {
        let date = self.diaryList.map {
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
        self.diaryList = data.compactMap {
            guard let title = $0["title"] as? String else { return nil }
            guard let content = $0["content"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil }
            guard let ispublic = $0["ispubic"] as? Bool else { return nil }
            return Task(title: title, content: content, done: done, ispublic: ispublic)
        }
        index = userDefaults.integer(forKey: "index")
    }
    private func takeLable() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        let nowDetaTime = formatter.string(from: Date())
        titleLable.text = diaryList[index].title
        contentsLable.text = diaryList[index].content
        dateLable.text = nowDetaTime
    }
}
