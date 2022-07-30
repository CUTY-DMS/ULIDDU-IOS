//
//  userWriteDiaryViewController.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/28.
//
import UIKit

enum ToDoEditorMode{
    case new
    case edit(IndexPath, ShareTitle)
}

protocol userWriteDiaryViewDelegate: AnyObject {
    func didSelectReigster(diary: ShareTitle)
}

class uesrWriteDiaryViewController: UIViewController {

    @IBOutlet var userDateTextField: UITextField!
    @IBOutlet var userContentsTextView: UITextView!
    @IBOutlet var userTitleTextField: UITextField!
    
    //    confirmButton
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    weak var delegate: userWriteDiaryViewDelegate?
    var toDoEditorMode : ToDoEditorMode = .new
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureContentsTextView()
        self.configureDatePicker()
        self.configureInputField()
        self.configureEditMode()
        print("userWritDiaryVC")
    }
    
    private func configureEditMode() {
        switch self.toDoEditorMode {
        case let .edit(_, shareTitle):
            self.userTitleTextField.text = shareTitle.title
            self.userContentsTextView.text = shareTitle.contents
            self.userDateTextField.text = self.dateToString(date: shareTitle.date)
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
        self.userContentsTextView?.layer.borderColor = borderColor.cgColor
        self.userContentsTextView?.layer.borderWidth = 0.5
        self.userContentsTextView?.layer.cornerRadius = 5.0
    }
    
    private func configureDatePicker() {
      self.datePicker.datePickerMode = .date
      self.datePicker.preferredDatePickerStyle = .wheels
      self.datePicker.addTarget(self, action: #selector(datePickerValudeDidChange(_:)), for: .valueChanged)
      self.datePicker.locale = Locale(identifier: "ko-KR")
      self.userDateTextField?.inputView = self.datePicker
    }
    
    private func configureInputField() {
      self.userContentsTextView?.delegate = self
      self.userTitleTextField?.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
      self.userDateTextField?.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
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
        self.userDateTextField?.text = formmatter.string(from: datePicker.date)
        self.userDateTextField?.sendActions(for: .editingChanged)
    }

    //유저가 화면 터치시 키보드 또는 다른 장치가 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func tapConfirmButton(_ sender: Any) {
        guard let title = self.userTitleTextField?.text else { return }
        guard let content = self.userContentsTextView?.text else { return }
        guard let date = self.diaryDate else { return }
        let diary = ShareTitle(title: title, contents: content, date: date)
        self.delegate?.didSelectReigster(diary: diary)
        //이전 화면 되돌리기
        self.navigationController?.popViewController(animated: true)
        print("수정 완료")
    }
}

extension uesrWriteDiaryViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
//    self.validateInputField()
  }
}
