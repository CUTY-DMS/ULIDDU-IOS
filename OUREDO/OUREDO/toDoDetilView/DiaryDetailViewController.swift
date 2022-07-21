//
//  DiaryDetailViewController.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/21.
//

import UIKit

protocol DiaryDetailViewDelegate: AnyObject {
    func didSelectDelegate(indexPath: IndexPath)
}

class DiaryDetailViewController: UIViewController {

    @IBOutlet var titleLable: UILabel!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var dateLable: UILabel!
    weak var delegate: DiaryDetailViewDelegate?
        
    var diary: Diary?
    var indexPath: IndexPath?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
        
    private func configureView() {
        guard let diary = self.diary else { return }
        self.titleLable.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateLable.text = self.dateToString(date: diary.date)
        }
                                                    
    private func dateToString(date: Date) -> String {
      let formatter = DateFormatter()
      formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
      formatter.locale = Locale(identifier: "ko_KR")
      return formatter.string(from: date)
    }
    
    @IBAction func tapEditButton(_ sender: UIButton) {
        
    }
        
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        guard let indexPath = self.indexPath else { return }
        self.delegate?.didSelectDelegate(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
}

