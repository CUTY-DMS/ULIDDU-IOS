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
    
    var getMyTodo: [GetToDoList] = []
    
//    var getDetilToDo: [DetailView] = []
    
    @objc var doneButton : UIButton!

    
    fileprivate weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        getMyToDoList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getMyToDoList()
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
            $0.width.equalTo(50)
            $0.trailing.equalTo(-320)
            $0.top.equalTo(180)
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
    }

    
    func nameLabelSet() {
        view.addSubview(nameLabel)
        
        nameLabel.textColor = .black
        nameLabel.text = "우리두"
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        nameLabel.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(40)
            $0.trailing.equalTo(-100)
            $0.top.equalTo(185)
            $0.leading.equalTo(160)
        }
    }
    
    
    private func getMyToDoList() {
        
        let url = "http://44.209.75.36:8080/todos/list?todoYearMonth=2022-08"
        let AT : String? = KeyChain.read(key: Token.accessToken)
        let header : HTTPHeaders = [
            "Authorization" : "Bearer \(AT!)"
        ]
        
        print("")
        print("====================================")
        print("주 소 :: ", url)
        print("====================================")
        print("")
        
        AF.request(url, method: .get, encoding: URLEncoding.queryString, headers: header).validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let res):
                    
                    do {
                        let data = try JSONDecoder().decode([GetToDoList].self, from: response.data!)
                        print(data)
                        self.getMyTodo = data
                        self.tableView.reloadData()
                    } catch {
                        print(error)
                    }
                    
                    print("")
                    print("-------------------------------")
                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
                    print("-------------------------------")
                    print("응답 데이터 :: ", String(data: res, encoding: .utf8) ?? "")
                    print("====================================")
                    debugPrint(response)
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
        return self.getMyTodo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeListCell", for: indexPath) as? HomeListCell else { return UITableViewCell() }
        
//        let mainList = self.getMyTodo[indexPath.row]
        
        cell.configure()
        
        
        cell.titleLable.text = "\(getMyTodo[indexPath.row].title)"
        cell.contentLable.text = "\(getMyTodo[indexPath.row].todoDate)"
        //configure에서 설정
        //        cell.textLabel?.text = mainList.title
        //        cell.detailTextLabel?.text = mainList.content
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailViewController = HomeDetilViewController()
//        detailViewController.task = selectedHomeList
//        self.show(detailViewController, sender: nil)
        
        //데이터를 받아오지 못함
        
        let selectedHomeList = getMyTodo[indexPath.row]
        let goToHomeDetilViewControllerVC = UserDetilViewController()
        self.show(goToHomeDetilViewControllerVC, sender: nibName)
    }
}
