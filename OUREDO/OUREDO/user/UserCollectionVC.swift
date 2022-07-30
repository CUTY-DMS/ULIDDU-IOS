//
//  UserCollectionVC.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/28.
//

import UIKit
import Alamofire

class userCollectionViewController: UIViewController{

    @IBOutlet var userName: UILabel!
    @IBOutlet var userCollectionView: UICollectionView!
    
    private var taskList = [Task]() {
        didSet {
            self.saveTasks()
        }
    }
    var result: [resultsArr] = []
    
    struct resultsArr: Codable {
        
        var title : String
        var content : String
        var done : Bool
        var ispublic : Bool
        
    }
    
    let name: String = ""
    let userId: String = ""
    let age: String = ""
    
    var shareTitle: ShareTitle?
    var indexPath: IndexPath?
    var index: Int = 0
    let refresh = UIRefreshControl()
    
override func viewDidLoad() {
        super.viewDidLoad()
    self.userCollectionView.dataSource = self
    self.userCollectionView.delegate = self
    self.initRefresh()
        self.configureCollectionView()
        self.loadDiaryList()
        self.getUserList()
        print("userCollectionVC")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadDiaryList()
    }
    //창이 뜨지 않음
    private func getUserList() {
        
        let formatter = DateFormatter()
        let date = Date()
        formatter.dateFormat = "yyyy-MM-dd"
        let nowDetaTime = formatter.string(from: date)
        print("지금 시간은 : \(nowDetaTime)")
        
        let url = "http://44.209.75.36:8080/todo/list"
        let AT : String? = KeyChain.read(key: Token.accessToken)
        let body: Parameters = [
            "todo-year-month" : nowDetaTime
        ]
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        var header = HTTPHeaders()
        header.update(name: "Authorization", value: "Bearer \(AT!)")

        AF.request(url, method: .get, parameters: body, headers: header).response { (response) in switch response.result {
                case .success(_):
                    debugPrint(response)
                    print("여기까지 성공 ❤️")
                    if let data = try? JSONDecoder().decode([resultsArr].self, from: response.data!){
                        DispatchQueue.main.async {
                            self.result = data
                            print(data)
                        }
                    }
                case .failure(let error):
                    print(error)
                }
        }
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
//새로 고침
extension userCollectionViewController {
    
    func initRefresh() {
        refresh.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        refresh.backgroundColor = UIColor.clear
        self.userCollectionView.refreshControl = refresh
    }
 
    @objc func refreshTable(refresh: UIRefreshControl) {
        print("refreshTable")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.userCollectionView.reloadData()
            refresh.endRefreshing()
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y < -0.1) {
            self.refreshTable(refresh: self.refresh)
        }
    }
 
}
