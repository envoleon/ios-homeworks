//
//  LogInViewController.swift
//  Navigation Table
//
//  Created by Александр Лебедев on 30.05.2022.
//

import UIKit


class LogInViewController: UIViewController {

    private lazy var logInView = LogInView(self)
    private let nc = NotificationCenter.default

    override func loadView() {
        view = logInView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nc.addObserver(self, selector: #selector(kdbShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kdbHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        nc.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @objc
    private func kdbShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            logInView.scrollView.contentInset.bottom = kbdSize.height
            logInView.scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
        }
    }

    @objc
    private func kdbHide() {
        logInView.scrollView.contentInset = .zero
        logInView.scrollView.verticalScrollIndicatorInsets = .zero
    }

    @objc
    private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        if let textField = logInView.textEditingChanged {
            textField.resignFirstResponder()
        }
    }
}

extension LogInViewController: LogInViewDelegate {
    func LogInButtonProfile() {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }

    func LogInTextEnding(_ textField: UITextField) {
        logInView.textEditingChanged = textField
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}


