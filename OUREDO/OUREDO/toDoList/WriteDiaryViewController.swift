//
//  WriteDiaryViewController.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/18.
//


import UIKit

protocol WriteDiaryViewDelegate: AnyObject {
    func didSelectReigster(diary : Diary)
}

class WriteDiaryViewController: UIViewController{
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var confirmButton: UIButton!
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    weak var delegate: WriteDiaryViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureContentsTextView()
        self.configureDatePicker()
        self.configureInputField()
        self.confirmButton.isEnabled = false
    }
    
}
