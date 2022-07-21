//
//  DiaryDetailVC.swift
//  Pods
//
//  Created by 박준하 on 2022/07/21.
//

import UIKit

protocol DiaryDetailViewDelegate: AnyObject {
    func didSelectDelegate(indexPath: IndexPath)
}

class DiaryDetailVC: UIViewController {

    @IBOutlet var titleLable: UILabel!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var dateLable: UILabel!
    weak var delegate: DiaryDetailViewDelegate?
    
    private var diaryList = [Task]() {
        didSet {
            self.saveTasks()
        }
    }
        
    var diary: Diary?
    var indexPath: IndexPath?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.loadDiaryList()
        self.takeLable()
    }
        
    private func configureView() {
        guard let diary = self.diary else { return }
        self.titleLable.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateLable.text = self.dateToString(date: diary.date)
        }
                                                    
    private func dateToString(date: Date) -> String {
      let formatter = DateFormatter()
      formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
      formatter.locale = Locale(identifier: "ko_KR")
      return formatter.string(from: date)
    }
    
    //userDefaults의 값 저장하기
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
    }
    private func takeLable() {
        let index = UserDefaults.standard.integer(forKey: "index")
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        let nowDetaTime = formatter.string(from: Date())
        titleLable.text = diaryList[index].title
        contentsTextView.text = diaryList[index].content
        dateLable.text = nowDetaTime
    }
    
    
    @IBAction func tapEditButton(_ sender: UIButton) {
        
    }
        
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        guard let indexPath = self.indexPath else { return }
        self.delegate?.didSelectDelegate(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
}

