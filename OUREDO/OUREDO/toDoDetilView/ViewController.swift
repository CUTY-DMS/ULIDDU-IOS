//
//  ViewController.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/19.
//

import UIKit

class viewController: UIViewController {

    @IBOutlet var titleLable: UILabel!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var dateLable: UILabel!
    var task : Task?
    var diary : Diary?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    private func configureView() {
        guard let task = task else { return }
        guard let diary = diary else { return }
        self.titleLable.text = task.title[IndexPath]
        self.contentsTextView.text = task.content
        self.dateLable.text = self.dateToString(date: diary.date)
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    
}
