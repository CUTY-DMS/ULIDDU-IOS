//
//  DiaryCell.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/21.
//

import UIKit

class DiaryCell: UICollectionViewCell {
    
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var dateLable: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //테두리 주기
        self.contentView.layer.cornerRadius = 3.0
        self.contentView.layer.borderWidth = 1.0
        //테두리를 검정으로 바꾸기
        self.contentView.layer.borderColor = UIColor.black.cgColor
    }
}
