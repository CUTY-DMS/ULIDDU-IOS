//
//  WriteDiaryViewController.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/21.
//

import UIKit

enum ToDoEditorMode1{
    case new
    case edit(IndexPath, ShareTitle)
}

protocol WriteDiaryViewDelegate: AnyObject {
    func didSelectReigster(diary: ShareTitle)
}

class WriteDiaryViewController: UIViewController {

    @IBOutlet var mainTitleTextField: UITextField!
    @IBOutlet var mainContentsTextView: UITextView!
    @IBOutlet var mainDateTextField: UITextField!
    //    confirmButton
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    weak var delegate: WriteDiaryViewDelegate?
    var toDoEditorMode : ToDoEditorMode1 = .new
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureContentsTextView()
        self.configureDatePicker()
        self.configureInputField()
//        self.confirmButton.isEnabled = false
        self.configureEditMode()
        print("WritDiaryVC")
    }
    
    private func configureEditMode() {
        switch self.toDoEditorMode {
        case let .edit(_, shareTitle):
            self.mainTitleTextField.text = shareTitle.title
            self.mainContentsTextView.text = shareTitle.contents
            self.mainDateTextField.text = self.dateToString(date: shareTitle.date)
            self.diaryDate = shareTitle.date
            
        default:
            break
        }
    }
    
    private func dateToString(date: Date) -> String {
      let formatter = DateFormatter()
      formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
      formatter.locale = Locale(identifier: "ko_KR")
      return formatter.string(from: date)
    }
    
    // textView 선 표시 및 색 지정
    private func configureContentsTextView() {
        let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        self.mainContentsTextView?.layer.borderColor = borderColor.cgColor
        self.mainContentsTextView?.layer.borderWidth = 0.5
        self.mainContentsTextView?.layer.cornerRadius = 5.0
    }
    
    private func configureDatePicker() {
      self.datePicker.datePickerMode = .date
      self.datePicker.preferredDatePickerStyle = .wheels
      self.datePicker.addTarget(self, action: #selector(datePickerValudeDidChange(_:)), for: .valueChanged)
      self.datePicker.locale = Locale(identifier: "ko-KR")
      self.mainDateTextField?.inputView = self.datePicker
    }
    
    private func configureInputField() {
      self.mainContentsTextView?.delegate = self
      self.mainTitleTextField?.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
      self.mainDateTextField?.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func titleTextFieldDidChange(_ textField: UITextField) {
//      self.validateInputField()
    }

    @objc private func dateTextFieldDidChange(_ textField: UITextField) {
//      self.validateInputField()
    }
    
    
    @objc private func datePickerValudeDidChange(_ datePicker : UIDatePicker){
        //날짜 데이터를 원하는 형테롤 포멧
        let formmatter = DateFormatter()
        //원하는 날짜 데이터 입력
        formmatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        //한국어 설정
        formmatter.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        self.mainDateTextField?.text = formmatter.string(from: datePicker.date)
        self.mainDateTextField?.sendActions(for: .editingChanged)
    }

    //유저가 화면 터치시 키보드 또는 다른 장치가 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func tapConfirmButton(_ sender: Any) {
        guard let title = self.mainTitleTextField?.text else { return }
        guard let content = self.mainContentsTextView?.text else { return }
        guard let date = self.diaryDate else { return }
        let diary = ShareTitle(title: title, contents: content, date: date)
        self.delegate?.didSelectReigster(diary: diary)
        //이전 화면 되돌리기
        self.navigationController?.popViewController(animated: true)
        print("수정 완료")
    }
}

extension WriteDiaryViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
//    self.validateInputField()
  }
}
