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
    private var textLogin: UITextField?
    private var textPass: UITextField?

    private let logoImageView: UIImageView = UIImageView(image: UIImage(named: "Logo vk"))
    private let scrollView: UIScrollView = UIScrollView()
    private let contentView: UIView = UIView()

    private let authorizationView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.masksToBounds = false
        view.clipsToBounds = true
        view.tintColor = .blue
        return view
    }()

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
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(self.handleTextEnding), for: .editingDidBegin)
        return textField
    }

    private lazy var authorizationButton: UIButtonAlpha = {
        let buttonAlpha = UIButtonAlpha()
        buttonAlpha.setTitle("Log In", for: .normal)
        buttonAlpha.setTitleColor(UIColor.white, for: .normal)
        buttonAlpha.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        buttonAlpha.layer.cornerRadius = 10
        buttonAlpha.layer.masksToBounds = true
        buttonAlpha.addTarget(self, action: #selector(handleButtonProfile), for: .touchUpInside)
        return buttonAlpha
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
        addConstraint()

        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
    }

    private func createUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        view.addGestureRecognizer(tapGesture)

        [
            logoImageView,
            scrollView,
            contentView,
            authorizationView,
            authorizationButton,
        ].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        // Что значит вынести к блоку с описанием элементов?
        textLogin = authorizationTextField("Email of phone")
        textPass = authorizationTextField("Password")
        textPass!.isSecureTextEntry = true

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(authorizationView)
        authorizationView.addSubview(textLogin!)
        authorizationView.addSubview(textPass!)
        contentView.addSubview(authorizationButton)
    }

    private func addConstraint() {
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

            textLogin!.topAnchor.constraint(equalTo: authorizationView.topAnchor),
            textLogin!.bottomAnchor.constraint(equalTo: authorizationView.centerYAnchor),
            textLogin!.widthAnchor.constraint(equalTo: authorizationView.widthAnchor),
            textPass!.bottomAnchor.constraint(equalTo: authorizationView.bottomAnchor),
            textPass!.topAnchor.constraint(equalTo: authorizationView.centerYAnchor),
            textPass!.widthAnchor.constraint(equalTo: authorizationView.widthAnchor),

            authorizationButton.topAnchor.constraint(equalTo: authorizationView.bottomAnchor, constant: 16),
            authorizationButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            authorizationButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorizationButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            authorizationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
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
    private func handleTextEnding(textField: UITextField) {
        textEditingChanged = textField
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
