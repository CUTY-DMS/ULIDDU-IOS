//
//  UserListCell.swift
//  remakeULIDDU
//
//  Created by 박준하 on 2022/08/16.
//

import UIKit
import SnapKit
import Kingfisher

class UserListCell: UITableViewCell {
    
    let ULIDDUImageView = UIImageView()
    let titleLable = UILabel()
    let contentLable = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [ULIDDUImageView, titleLable, contentLable].forEach {
            contentView.addSubview($0)
        }
        
        ULIDDUImageView.contentMode = .scaleAspectFit
        titleLable.font = .systemFont(ofSize: 18, weight: .bold)
        titleLable.textColor = .black
        
        contentLable.font = .systemFont(ofSize: 14, weight: .light)
        contentLable.textColor = .gray
        contentLable.numberOfLines = 1
        
        ULIDDUImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.top.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(50)
            $0.height.equalTo(50)
        }
        
        titleLable.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.top.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(50)
            $0.height.equalTo(50)
        }
        contentLable.snp.makeConstraints {
            $0.leading.equalTo(ULIDDUImageView.snp.trailing).offset(10)
            $0.bottom.equalTo(ULIDDUImageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    func configure(whih task : Task) {
        let imageURL = URL(string: task.image)
        ULIDDUImageView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "ULIDDL-Logo"))
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
}

