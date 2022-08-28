import UIKit
import SwiftUI
import SnapKit
import Alamofire
import FSCalendar

class UserViewController : UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    let profile = UIView()
    let nameLabel = UILabel()
    let detailButton = UIButton()
    let ULIDDUImageView = UIImageView()
    let tableView = UITableView()
    
    let refresh = UIRefreshControl()
    
    var getMyTodo: [GetToDoList] = []
    var userView: UserContent = UserContent(name: "null", userID: "", age: 0)
    var detilView : [UserDetailTodo] = []
    
    @objc var doneButton : UIButton!

    
    fileprivate weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initRefresh()
        
        view.backgroundColor = .white
        //UINavigationBar 설정
        title = "임시 설정"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableviewSize()
        profileSet()
        lineView()
        nameLabelSet()
        configureDetailButton()
//        getMyToDoList()
        userName()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.initRefresh()
        getDetailList()
//        getMyToDoList()
    }
    
    
    func tableviewSize() {
        //UITableView 설정
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        
        tableView.register(HomeListCell.self, forCellReuseIdentifier: "HomeListCell")

        tableView.snp.makeConstraints{
            $0.height.equalTo(520)
            $0.width.equalTo(430)
            $0.trailing.equalTo(0)
            $0.top.equalTo(320)
            $0.leading.equalTo(0)
        }

    }
    
    func profileSet() {
        
        view.addSubview(profile)
        view.addSubview(ULIDDUImageView)
        ULIDDUImageView.image = UIImage(named: "ULIDDL-Logo2")
        ULIDDUImageView.backgroundColor = .black
        ULIDDUImageView.layer.cornerRadius = ULIDDUImageView.frame.width/8
        ULIDDUImageView.clipsToBounds = true
        profile.backgroundColor = .black
        profile.layer.cornerRadius = 50
        
        profile.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.width.equalTo(100)
            $0.trailing.equalTo(-300)
            $0.top.equalTo(160)
            $0.leading.equalTo(30)

        }
        
        ULIDDUImageView.snp.makeConstraints{
            $0.height.equalTo(50)
            $0.width.equalTo(30)
            $0.trailing.equalTo(-320)
            $0.top.equalTo(183)
            $0.leading.equalTo(50)
        }
    }
    func lineView() {
        let signUpLine = UIView()
        view.addSubview(signUpLine)
        signUpLine.backgroundColor = .black
        signUpLine.snp.makeConstraints{
            $0.height.equalTo(10)
            $0.width.equalTo(325)
            $0.trailing.equalTo(0)
            $0.top.equalTo(310)
            $0.leading.equalTo(0)
        }
    }
    
    func configureDetailButton() {
           detailButton.setTitle("상세보기", for: .normal)
           detailButton.backgroundColor = .black
           
           view.addSubview(detailButton)
           
           detailButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
           
           detailButton.snp.makeConstraints {
               $0.height.equalTo(35)
               $0.width.equalTo(115)
               $0.trailing.equalTo(-120)
               $0.top.equalTo(225)
               $0.leading.equalTo(160)
           }
           detailButton.addTarget(self, action: #selector(DetailButtonAction), for: .touchUpInside)
       }
    @objc func DetailButtonAction(sender: UIButton!){
        print(" 상세보기 버튼 실행됨")
        let goToUserSetVC = userSetViewConteller()
        goToUserSetVC.userName = "\(userView.name)"
        goToUserSetVC.userId = "\(userView.userID)"
        goToUserSetVC.userAge = userView.age
        self.show(goToUserSetVC, sender: nil)
    }

    
    func nameLabelSet() {
        view.addSubview(nameLabel)
        
        nameLabel.textColor = .black
        nameLabel.text = ""
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        nameLabel.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(40)
            $0.trailing.equalTo(-100)
            $0.top.equalTo(185)
            $0.leading.equalTo(160)
        }
    }
//
//    
//    private func getMyToDoList() {
//        
//        let url = "http://44.209.75.36:8080/todos/list?todoYearMonth=2022-08"
//        let AT : String? = KeyChain.read(key: Token.accessToken)
//        let header : HTTPHeaders = [
//            "Authorization" : "Bearer \(AT!)"
//        ]
//        
//        print("")
//        print("====================================")
//        print("주 소 :: ", url)
//        print("====================================")
//        print("")
//        
//        AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate(statusCode: 200..<300)
//            .responseData { response in
//                switch response.result {
//                case .success(let res):
//                    
//                    do {
//                        let data = try JSONDecoder().decode([GetToDoList].self, from: response.data!)
//                        print(data)
//                        self.getMyTodo = data
//                        self.tableView.reloadData()
//                        self.initRefresh()
//                    } catch {
//                        print(error)
//                    }
//                    
//                    print("")
//                    print("-------------------------------")
//                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
//                    print("-------------------------------")
//                    print("응답 데이터 :: ", String(data: res, encoding: .utf8) ?? "")
//                    print("====================================")
//                    debugPrint(response)
//                    print("-------------------------------")
//                    print("")
//                    
//                case .failure(let err):
//                    print("")
//                    print("-------------------------------")
//                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
//                    print("-------------------------------")
//                    print("에 러 :: ", err.localizedDescription)
//                    print("====================================")
//                    debugPrint(response)
//                    print("")
//                    break
//                }
//            }
//    }
    
    private func userName() {
        
        let url = "http://44.209.75.36:8080/user"
        let AT : String? = KeyChain.read(key: Token.accessToken)
        let header : HTTPHeaders = [
            "Authorization" : "Bearer \(AT!)"
        ]
        
        print("====================================")
        print("주 소 :: ", url)
        print("====================================")
        
        AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let res):
                    do {
                        let data = try JSONDecoder().decode(UserContent.self, from: response.data!)
                        print(data)
                        self.userView = data
                        print("🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸")
                        print("===userView는 data의 값을 보유 하고 있습니다===")
                        print("🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸🌸")
                        
                        
                        self.nameLabel.text = "\(self.userView.name)"
                    } catch {
                        print("🤬🤬🤬🤬🤬🤬🤬")
                        print(error)
                        print("🥵🥵🥵🥵🥵🥵🥵")
                    }
                    
                    print("")
                    print("-------------------------------")
                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
                    print("-------------------------------")
                    print("응답 데이터 :: ", String(data: res, encoding: .utf8) ?? "")
                    print("-------------------------------")
                    print("")
                    
                case .failure(let err):
                    print("")
                    print("-------------------------------")
                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
                    print("-------------------------------")
                    print("에 러 :: ", err.localizedDescription)
                    print("====================================")
                    debugPrint(response)
                    print("")
                    break
                }
            }
    }
    private func getDetailList() {
        
        let url = "http://44.209.75.36:8080/todos/v2/list?todoYearMonth=2022-08"
        let AT : String? = KeyChain.read(key: Token.accessToken)
        let header : HTTPHeaders = [
            "Authorization" : "Bearer \(AT!)"
        ]
        
        print("====================================")
        print("주 소 :: ", url)
        print("====================================")
        
        AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let res):
                    do {
                        let data = try JSONDecoder().decode([UserDetailTodo].self, from: response.data!)
                        print(data)
                        self.detilView = data
                        print("🌕🌕🌕🌕🌕🌕🌕🌕🌕🌕🌕")
                        print("===DetilView는 data의 값을 보유 하고 있습니다===")
                        print("🌕🌕🌕🌕🌕🌕🌕🌕🌕🌕🌕")
                        
                    } catch {
                        print("🤬🤬🤬🤬🤬🤬🤬")
                        print(error)
                        print("🥵🥵🥵🥵🥵🥵🥵")
                    }
                    print("")
                    print("-------------------------------")
                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
                    print("-------------------------------")
                    print("응답 데이터 :: ", String(data: res, encoding: .utf8) ?? "")
                    print("-------------------------------")
                    print("")
                    
                case .failure(let err):
                    print("")
                    print("-------------------------------")
                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
                    print("-------------------------------")
                    print("에 러 :: ", err.localizedDescription)
                    print("====================================")
                    debugPrint(response)
                    print("")
                    break
                }
            }
    }
}

//UITableView, DataSource, Delegate
extension UserViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detilView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeListCell", for: indexPath) as? HomeListCell else { return UITableViewCell() }
        
        cell.configure()
        
        cell.titleLable.text = "\(detilView[indexPath.row].title)"
        cell.contentLable.text = "\(detilView[indexPath.row].todoDate)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailPageIndexPath = detilView[indexPath.row]
        
        print(detailPageIndexPath)
//        
//        let detail = getDetailList(id: detailPageIndexPath.id)
//        
//        let goToHomeDetilViewControllerVC = UserDetilViewController()
//        
//        goToHomeDetilViewControllerVC.Detail = detailPageIndexPath
//        
//        self.show(goToHomeDetilViewControllerVC, sender: nibName)
        
//        let petListIndexPath = showList.pets[indexPath.row]
//        let showDetailViewController = ShowPetDetailViewController()
//        showDetailViewController.pets = petListIndexPath
//        self.show(showDetailViewController, sender: nil)
        
//        let selectedHomeList = getMyTodo[indexPath.row]
//        let goToHomeDetilViewControllerVC = UserDetilViewController()
//        goToHomeDetilViewControllerVC.Detail = selectedHomeList
//        self.show(goToHomeDetilViewControllerVC, sender: nibName)
    }
}

//새로 고침
extension UserViewController {
    
    func initRefresh() {
        refresh.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        refresh.backgroundColor = UIColor.clear
        self.tableView.refreshControl = refresh
    }
 
    @objc func refreshTable(refresh: UIRefreshControl) {
        print("새로고침")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.tableView.reloadData()
//            self.getMyToDoList()
            self.viewDidLoad()
            refresh.endRefreshing()
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y < -0.1) {
            self.refreshTable(refresh: self.refresh)
        }
    }
 
}
