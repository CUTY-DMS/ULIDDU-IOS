//
//  MainHomeViewController.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/12.
//

import UIKit
import SwiftUI
import SnapKit

class MainHomeViewController : UIViewController {
        
    let testArr = ["a", "b", "c", "d", "a", "b", "c", "d", "a", "b", "c", "d", "a", "b", "c", "d"]
    let table = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        attribute()
        layout()
    }
    
    func attribute() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func layout() {
        view.addSubview(table)
        table.snp.makeConstraints {
            $0.trailing.leading.bottom.equalTo(0)
            $0.top.equalTo(500)
        }
    }
}

extension MainHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = testArr[indexPath.row]
        
        return cell
    }
}


struct TableViewRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainHomeViewController {
        return MainHomeViewController()
    }
    
    func updateUIViewController(_ uiViewController: MainHomeViewController, context: Context) { }
    
    typealias UIViewControllerType = MainHomeViewController
    
}

@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
        TableViewRepresentable()
    }
}
