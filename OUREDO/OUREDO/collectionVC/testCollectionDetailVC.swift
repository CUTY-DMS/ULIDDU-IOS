//
//  testCollectionDetailVC.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/25.
//

import UIKit

protocol collectionDetailViewDelegate: AnyObject {
    func didSelectDelegate(indexPath: IndexPath)
}

class testCollectionDetailVC: UIViewController {

    @IBOutlet var titleLable: UILabel!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var dateLable: UILabel!
    weak var delegate: collectionDetailViewDelegate?
    
    private var taskList = [Task]() {
        didSet {
            self.saveTasks()
        }
    }
        
    var shareTitle: ShareTitle?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.loadDiaryList()
        self.takeLable()
    }
        
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
        contentsTextView?.text = taskList[index].content
        dateLable.text = nowDetaTime
    }
    
    @IBAction func tapEditButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "WriteDiaryViewController") as? WriteDiaryViewController else { return }
        guard let indexPath = indexPath else { return }
        guard let diary = shareTitle else { return }
        viewController.toDoEditorMode = .edit(indexPath, diary)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
        
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

