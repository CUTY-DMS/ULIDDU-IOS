//
//  HomeDetilViewController.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/14.
//

import UIKit
import Alamofire

class UserDetilEditViewController : UITableViewController {
    
    var Detil : [UserDetailTodo] = []

      
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HomeDetailListCell")
        tableView.rowHeight = UITableView.automaticDimension

        //디테일뷰의 이미지 크기
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        let headerView = UIImageView(frame: frame)


        headerView.contentMode = .scaleAspectFit
        headerView.image = UIImage(named: "ULIDDL-Logo1")


        tableView.tableHeaderView = headerView
    }
}

//UITableView delegate dataSource
extension UserDetilEditViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "id"
        case 1:
            return "제목"
        case 2:
            return "내용"
        case 3:
            return "작성자"
        case 4:
            return "작성 날짜"
        case 5:
            return "수정 날짜"
        case 6:
            return "성공 여부"
        case 7:
            return "공개 여부"
        case 8:
            return "좋아요 여부"
        case 9:
            return "좋아요 개수"
        default:
            return nil
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .default, reuseIdentifier: "HomeDetailListCell")

        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        
        let formatter = DateFormatter()
        let date = Date()
        formatter.dateFormat = "yyyy-MM-dd"
        let nowDetaTime = formatter.string(from: date)

        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "\(Detil[indexPath.row].id)"
            return cell
        case 1:
            cell.textLabel?.text = "\(Detil[indexPath.row].title)"
            return cell
        case 2:
            cell.textLabel?.text = "\(Detil[indexPath.row].content)" //타입 변환 해야함
            return cell
        case 3:
            cell.textLabel?.text = "\(Detil[indexPath.row].writer)" //타입 변환 해야함
            return cell
        case 4:
            cell.textLabel?.text = "\(Detil[indexPath.row].todoDate)"
            return cell
        case 5:
            cell.textLabel?.text = "\(nowDetaTime)"
            return cell
        case 6:
            cell.textLabel?.text = "\(Detil[indexPath.row].iscompleted)" //타입 변환 해야함
            return cell
        case 7:
            cell.textLabel?.text = "\(Detil[indexPath.row].ispublic)" //타입 변환 해야함
            return cell
        case 8:
            cell.textLabel?.text = "\(Detil[indexPath.row].isliked)" //타입 변환 해야함
            return cell
        case 9:
            cell.textLabel?.text = "\(Detil[indexPath.row].likeCount)" //타입 변환 해야함
            return cell
        default:
            return cell
        }
    }
}
