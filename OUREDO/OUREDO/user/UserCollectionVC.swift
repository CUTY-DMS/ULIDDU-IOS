//
//  UserCollectionVC.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/28.
//

import UIKit

class userCollectionViewController: UIViewController{

    @IBOutlet var userCollectionView: UICollectionView!
    
    private var taskList = [Task]() {
        didSet {
            self.saveTasks()
        }
    }
    
    var shareTitle: ShareTitle?
    var indexPath: IndexPath?
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.loadDiaryList()
        print("userCollectionVC")
    }
    
    private func configureCollectionView() {
        self.userCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.userCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.userCollectionView.delegate = self
        self.userCollectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let uesrWriteDiaryViewController = segue.destination as? uesrWriteDiaryViewController {
          uesrWriteDiaryViewController.delegate = self
    }
}

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
//      self.diaryList = self.diaryList.sorted(by: {
//        $0.date.compare($1.date) == .orderedDescending
//      })
  }
    private func dateToString(date: Date) -> String {
      let formatter = DateFormatter()
      formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
      formatter.locale = Locale(identifier: "ko_KR")
      return formatter.string(from: date)
    }
}

extension userCollectionViewController: UICollectionViewDataSource{
    //collection뷰 위치에 표시할 셀을 표시하는 메소드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.taskList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserToDoCell", for: indexPath) as? UserToDoCell else { return UICollectionViewCell() }
        let diary = self.taskList[indexPath.row]
        //오류 = 무조건 현제 날짜만 나옴
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        let nowDetaTime = formatter.string(from: Date())
        cell.userTitleLable.text = diary.title
        cell.userDateLable.text = nowDetaTime
        return cell
    }
}

extension userCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (UIScreen.main.bounds.width / 2) - 20, height: 200)
  }
}

extension userCollectionViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let viewContoller = self.storyboard?.instantiateViewController(identifier: "userCollectionDetailVC") as? userCollectionDetailVC else { return }
//    let diary = self.taskList[indexPath.row]
    viewContoller.indexPath = indexPath
    viewContoller.delegate = self
    UserDefaults.standard.set(indexPath.row, forKey: "index")
    self.navigationController?.pushViewController(viewContoller, animated: true)
  }
}

extension userCollectionViewController: userWriteDiaryViewDelegate {
  func didSelectReigster(diary: ShareTitle) {
    self.userCollectionView.reloadData()
  }
}
extension userCollectionViewController: userCollectionDetailViewDelegate {
    func didSelectDelegate(indexPath: IndexPath) {
        self.taskList.remove(at: indexPath.row)
        self.userCollectionView.deleteItems(at: [indexPath])
    }
}

