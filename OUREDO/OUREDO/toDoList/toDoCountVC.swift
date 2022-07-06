//
//  toDoCountVC.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/06.
//

import UIKit

class toDoCountVC: UIViewController, UITextViewDelegate {

    let textViewPlaceHolder = "텍스트를 입력하세요"

    lazy var textView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        view.textContainerInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        view.font = .systemFont(ofSize: 18)
        view.text = textViewPlaceHolder
        view.textColor = .lightGray
        view.delegate = self

        return view
    }()

    lazy var remainCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "0/700"
        label.font = .systemFont(ofSize: 30)
        label.textColor = .lightGray
        label.textAlignment = .center

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(textView)
        view.addSubview(remainCountLabel)

        textView.translatesAutoresizingMaskIntoConstraints = false
        remainCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textView.heightAnchor.constraint(equalToConstant: 300),

            remainCountLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 12),
            remainCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTextView(_:)))
        view.addGestureRecognizer(tapGesture)
    }

    @objc
    private func didTapTextView(_ sender: Any) {
        view.endEditing(true)
    }

    private func updateCountLabel(characterCount: Int) {
        remainCountLabel.text = "\(characterCount)/500"
        remainCountLabel.asColor(targetString: "\(characterCount)", color: characterCount == 0 ? .lightGray : .blue)
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .lightGray
            updateCountLabel(characterCount: 0)
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)

        let characterCount = newString.count
        guard characterCount <= 700 else { return false }
        updateCountLabel(characterCount: characterCount)

        return true
    }
}

extension UILabel {
    func asColor(targetString: String, color: UIColor?) {
        let fullText = text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.foregroundColor, value: color as Any, range: range)
        attributedText = attributedString
    }
}
