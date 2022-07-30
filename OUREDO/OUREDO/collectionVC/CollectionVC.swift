//
//  collectionViewController.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/21.
//


import UIKit

class collectionViewController: UIViewController, UISearchResultsUpdating{

    @IBOutlet var collectionView: UICollectionView!
    
    let searchController = UISearchController()
    let refresh = UIRefreshControl()

    private var taskList = [Task]() {
        didSet {
            self.saveTasks()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadDiaryList()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.loadDiaryList()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.initRefresh()

        print("collectionVC")
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        print(text)
    }
    
    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let WriteDiaryViewController = segue.destination as? WriteDiaryViewController {
          WriteDiaryViewController.delegate = self
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
//    let diary = self.taskList[indexPath.row]
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
//새로 고침
extension collectionViewController {
    
    func initRefresh() {
        refresh.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        refresh.backgroundColor = UIColor.clear
        self.collectionView.refreshControl = refresh
        self.collectionView.reloadData()
    }
 
    @objc func refreshTable(refresh: UIRefreshControl) {
        print("refreshTable")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.collectionView.reloadData()
            refresh.endRefreshing()
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y < -0.1) {
            self.refreshTable(refresh: self.refresh)
            self.collectionView.reloadData()
        }
    }
 
}
