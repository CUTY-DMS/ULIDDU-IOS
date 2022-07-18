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
    
    // textView 선 표시 및 색 지정
    private func configureContentsTextView() {
        let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        self.contentsTextView.layer.borderColor = borderColor.cgColor
        self.contentsTextView.layer.borderWidth = 0.5
        self.contentsTextView.layer.cornerRadius = 5.0
    }
    
    private func configureDatePicker() {
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self, action: #selector(datePickerValudeDidChange(_:) ), for: .valueChanged)
        self.dateTextField.inputView = self.datePicker
        self.datePicker.locale = Locale(identifier: "ko-KR")
    }
    
    private func configureInputField() {
        self.contentsTextView.delegate = self
        self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        self.dateTextField.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func titleTextFieldDidChange(_ textField : UITextField){
        self.validateInputField()
    }
    
    @objc private func dateTextFieldDidChange(_ textField : UITextField) {
        self.validateInputField()
    }
    
    
    @objc private func datePickerValudeDidChange(_ datePicker : UIDatePicker){
        //날짜 데이터를 원하는 형테롤 포멧
        let formmatter = DateFormatter()
        //원하는 날짜 데이터 입력
        formmatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        //한국어 설정
        formmatter.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        self.dateTextField.text = formmatter.string(from: datePicker.date)
        self.dateTextField.sendActions(for: .editingChanged)
    }

    //유저가 화면 터치시 키보드 또는 다른 장치가 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func tapConfirmButton(_ sender: UIButton) {
        guard let title = self.titleTextField.text else { return }
        guard let content = self.contentsTextView.text else { return }
        guard let date = self.diaryDate else { return }
        let diary = Diary(title: title, content: content, date: date, isStar: false)
        self.delegate?.didSelectReigster(diary: diary)
        //이전 화면 되돌리기
        self.navigationController?.popViewController(animated: true)
    }
}
