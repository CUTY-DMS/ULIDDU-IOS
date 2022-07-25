//
//  collectionViewController.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/21.
//


import UIKit

class collectionViewController: UIViewController{

    @IBOutlet var collectionView: UICollectionView!
    
    private var taskList = [Task]() {
        didSet {
            self.saveTasks()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.loadDiaryList()
    }
    
    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let wireDiaryViewContoller = segue.destination as? WriteDiaryViewController {
        wireDiaryViewContoller.delegate = self
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

extension collectionViewController: UICollectionViewDataSource{
    //collection뷰 위치에 표시할 셀을 표시하는 메소드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.taskList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToDoCell", for: indexPath) as? ToDoCell else { return UICollectionViewCell() }
        let diary = self.taskList[indexPath.row]
        //오류 = 무조건 현제 날짜만 나옴
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        let nowDetaTime = formatter.string(from: Date())
        cell.titleLable.text = diary.title
        cell.dateLable.text = nowDetaTime
        return cell
    }
}

extension collectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (UIScreen.main.bounds.width / 2) - 20, height: 200)
  }
}

extension collectionViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let viewContoller = self.storyboard?.instantiateViewController(identifier: "CollectionDetailVC") as? CollectionDetailVC else { return }
    let diary = self.taskList[indexPath.row]
    viewContoller.indexPath = indexPath
    viewContoller.delegate = self
    UserDefaults.standard.set(indexPath.row, forKey: "index")
    self.navigationController?.pushViewController(viewContoller, animated: true)
  }
}

extension collectionViewController: WriteDiaryViewDelegate {
  func didSelectReigster(diary: ShareTitle) {
    self.collectionView.reloadData()
  }
}
extension collectionViewController: CollectionDetailViewDelegate {
    func didSelectDelegate(indexPath: IndexPath) {
        self.taskList.remove(at: indexPath.row)
        self.collectionView.deleteItems(at: [indexPath])
    }
}
