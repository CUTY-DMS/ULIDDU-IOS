//
//  BeerDetailViewController.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/16.
//

import UIKit

class BeerDetailViewController : UITableViewController {
    var beer: Beer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = beer?.title ?? "이름 없는 맥주"
        
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BeerDetailListCell")
        tableView.rowHeight = UITableView.automaticDimension
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        let headerView = UIImageView(frame: frame)
        let imageURL = URL(string: beer?.imageURL ?? "")
        
        headerView.contentMode = .scaleAspectFit
        headerView.kf.setImage(with: imageURL, placeholder: UIImage(named: "swift"))
        
        tableView.tableHeaderView = headerView
    }
}

//UITableView delegate dataSource
extension BeerDetailViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        default:
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Id"
        case 1:
            return "todoDate"
        case 2:
            return "title"
        case 3:
            return "실험"
        default:
            return nil
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "BeerDetailListCell")
        
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = beer?.id
            return cell
        case 1:
            cell.textLabel?.text = beer?.todoDate ?? "설명이 없는 맥주"
            return cell
        case 2:
            cell.textLabel?.text = beer?.title ?? "팁 없는 맥주"
            return cell
        case 3:
            return cell
        default:
            return cell
        }
    }
}
