//
//  LogInViewController.swift
//  Navigation Table
//
//  Created by Александр Лебедев on 30.05.2022.
//

import UIKit


class LogInViewController: UIViewController {

    private let nc = NotificationCenter.default
    private var textEditingChanged: UITextField?

    private let logoImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView(image: UIImage(named: "Logo vk")))

    private let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())

    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    private let authorizationView: UIView = {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.masksToBounds = false
        $0.clipsToBounds = true
        $0.tintColor = .blue
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    private lazy var authorizationTextField: (String) -> UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.tintColor = UIColor(named: "#4885CC")
        textField.layer.borderWidth = 0.25
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font? = UIFont.systemFont(ofSize: 16)
        textField.autocorrectionType = .no
        textField.placeholder = $0
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.delegate = self
        textField.addTarget(self, action: #selector(self.handleTextEnding), for: .editingDidBegin)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }

    @objc
    private func handleTextEnding(textField: UITextField) {
        textEditingChanged = textField
    }

    private lazy var authorizationButton: UIButtonAlpha = {
        $0.setTitle("Log In", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(handleButtonProfile), for: .touchUpInside)
        return $0
    }(UIButtonAlpha())

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true

        createUI()
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
            scrollView.contentInset.bottom = kbdSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
        }
    }

    @objc
    private func kdbHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

    @objc
    private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        if let textField = textEditingChanged {
            textField.resignFirstResponder()
        }
    }

    private func createUI() {

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        view.addGestureRecognizer(tapGesture)

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(logoImageView)
        contentView.addSubview(authorizationView)

        let textLogin = authorizationTextField("Email of phone")
        let textPass = authorizationTextField("Password")
        textPass.isSecureTextEntry = true
        authorizationView.addSubview(textLogin)
        authorizationView.addSubview(textPass)

        contentView.addSubview(authorizationButton)

        let safeAreaScroll = scrollView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([

            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: safeAreaScroll.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: safeAreaScroll.widthAnchor),

            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),

            authorizationView.heightAnchor.constraint(equalToConstant: 100),
            authorizationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorizationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            authorizationView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),

            textLogin.topAnchor.constraint(equalTo: authorizationView.topAnchor),
            textLogin.bottomAnchor.constraint(equalTo: authorizationView.centerYAnchor),
            textLogin.widthAnchor.constraint(equalTo: authorizationView.widthAnchor),
            textPass.bottomAnchor.constraint(equalTo: authorizationView.bottomAnchor),
            textPass.topAnchor.constraint(equalTo: authorizationView.centerYAnchor),
            textPass.widthAnchor.constraint(equalTo: authorizationView.widthAnchor),

            authorizationButton.topAnchor.constraint(equalTo: authorizationView.bottomAnchor, constant: 16),
            authorizationButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            authorizationButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorizationButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            authorizationButton.heightAnchor.constraint(equalToConstant: 50)


        ])
    }

    @objc
    private func handleButtonProfile(){
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
