//
//  MainHomeViewController.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/12.
//

import UIKit
import SwiftUI
import SnapKit

class MainHomeViewController : UITableViewController {
    
    var homeList = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UINavigationBar 설정
        title = "임시 설정"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //UITableView 설정
        tableView.register(HomeListCell.self, forCellReuseIdentifier: "HomeListCell")
        tableView.rowHeight = 150
        
        
    }
}

//UITableView, DataSource, Delegate
extension MainHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeListCell", for: indexPath) as? HomeListCell else { return UITableViewCell() }
        
        let mainList = homeList[indexPath.row]
        cell.configure(whih: mainList)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHomeList = homeList[indexPath.row]
        
    }
}

