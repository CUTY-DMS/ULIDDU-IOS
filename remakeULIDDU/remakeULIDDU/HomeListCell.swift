//
//  mainTodoListCell.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/14.
//

import UIKit
import SnapKit

class HomeListCell: UITableViewCell {
    
    let titleLable = UILabel()
    let contentLable = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [titleLable, contentLable].forEach {
            contentView.addSubview($0)
        }
        
        titleLable.font = .systemFont(ofSize: 18, weight: .bold)
        titleLable.textColor = .black
        contentLable.font = .systemFont(ofSize: 14, weight: .light)
        contentLable.textColor = .gray
        contentLable.numberOfLines = 0
        
        titleLable.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.top.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        contentLable.snp.makeConstraints {
            $0.leading.equalTo(titleLable.snp.trailing).offset(10)
            $0.bottom.equalTo(titleLable.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    func configure(whih task : Task) {
        titleLable.text = task.title ?? "제목을 받을 수 없음"
        contentLable.text = task.content
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
}

