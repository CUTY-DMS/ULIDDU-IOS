//
//  PublicFeedViewController.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/12.
//

import UIKit
import Alamofire

class PublicFeedViewController : UIViewController {
    
    var getMyTodo: [GetToDoList] = []
    let tableView = UITableView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableviewSize()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableviewSize() {
        //UITableView 설정
        view.addSubview(tableView)
        tableView.backgroundColor = .black
        
        tableView.register(HomeListCell.self, forCellReuseIdentifier: "HomeListCell")

        tableView.snp.makeConstraints{
            $0.height.equalTo(275)
            $0.width.equalTo(430)
            $0.trailing.equalTo(0)
            $0.top.equalTo(515)
            $0.leading.equalTo(0)
        }

    }
    
}


//UITableView, DataSource, Delegate
extension PublicFeedViewController : UITableViewDataSource, UITableViewDelegate {
    
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
        
//        let selectedHomeList = getMyTodo[indexPath.row]
//        let goToHomeDetilViewControllerVC = HomeDetilViewController()
//        self.show(goToHomeDetilViewControllerVC, sender: nibName)
    }
}
