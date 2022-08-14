//
//  HomeDetilViewController.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/14.
//

import UIKit

class HomeDetilViewController : UITableViewController {
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = task?.title ?? "제목을 모름"
        
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HomeDetailListCell")
        tableView.rowHeight = UITableView.automaticDimension
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        let headerView = UIImageView(frame: frame)
        let imageURL = URL(string: task?.image ?? "ULIDDL-Logo")
        
        headerView.contentMode = .scaleAspectFit
        headerView.kf.setImage(with: imageURL, placeholder: UIImage(named: ""))
        
        tableView.tableHeaderView = headerView
    }
}

//UITableView delegate dataSource
extension HomeDetilViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "제목"
        case 1:
            return "내용"
        case 2:
            return "작성 날짜"
        case 3:
            return "공개 여부"
        case 4:
            return "하트 개수"
        default:
            return nil
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "HomeDetailListCell")
        
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = task?.title ?? "제목이 없습니다"
            return cell
        case 1:
            cell.textLabel?.text = task?.content ?? "설명이 없는 내용"
            return cell
        case 2:
            cell.textLabel?.text = "\(Bool.self)" //타입 변환 해야함
            return cell
        case 3:
            cell.textLabel?.text = "\(Bool.self)" //타입 변환 해야함
            return cell
        default:
            return cell
        }
    }
}
