//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Александр Лебедев on 24.05.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    var textEditingChanged: UITextField?
    private var statusTextField: String?

    private let avatarImageView: UIImageView = {
        $0.layer.cornerRadius = 96 / 2
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.masksToBounds = false
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView(image: UIImage(named: "profile-image")))

    private let fullNameLabel: UILabel = {
        $0.text = "The cat is dumb"
        $0.font? = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    let newButtonText: (String, Selector) -> UIButton = {
        let button = UIButton()
        button.setTitle($0, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = false
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: $1, for: .touchUpInside)
        return button
    }

    private let profileWait: UILabel = {
        $0.text = "Waiting for something..."
        $0.font? = UIFont.systemFont(ofSize: 14, weight: .light)
        $0.textColor = .gray
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    lazy var statusLabel: UITextField = {
        $0.backgroundColor = .white
        $0.textColor = .black
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.font? = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        $0.leftViewMode = .always
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(statusTextFieldChanged(_:)), for: .editingChanged)
        $0.addTarget(self, action: #selector(handleTextEnding), for: .editingDidBegin)
        return $0
    }(UITextField())

    override init(frame: CGRect) {
        super.init(frame: frame)

        createUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createUI() {

        

        self.addSubview(avatarImageView)
        self.addSubview(fullNameLabel)
        let setStatusButton = newButtonText("show status", #selector(getStatusPressed))
        self.addSubview(setStatusButton)
        self.addSubview(profileWait)
        self.addSubview(statusLabel)


        let safeArea = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 96),
            avatarImageView.heightAnchor.constraint(equalToConstant: 96),

            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            fullNameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 27),

            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),

            profileWait.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -8),
            profileWait.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),

            statusLabel.heightAnchor.constraint(equalToConstant: 40),
            statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -16),
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])
    }

    @objc
    private func handleTextEnding(textField: UITextField) {
        textEditingChanged = textField
    }

    @objc
    private func getStatusPressed() {
        if let text = statusTextField {
            profileWait.text = text
            print(profileWait.text!)
        }
    }

    @objc
    private func statusTextFieldChanged(_ textField: UITextField) {
        statusTextField = statusLabel.text
    }
}
