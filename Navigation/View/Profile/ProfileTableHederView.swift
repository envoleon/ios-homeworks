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
    private var setStatusButton: UIButton?

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profile-image"))
        imageView.layer.cornerRadius = 96 / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        return imageView
    }()

    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "The cat is dumb"
        label.font? = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    lazy var newButtonText: (String, Selector) -> UIButton = {
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
        button.addTarget(self, action: $1, for: .touchUpInside)
        return button
    }

    private let profileWait: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.font? = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        return label
    }()

    lazy var statusLabel: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font? = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(statusTextFieldChanged(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(handleTextEnding), for: .editingDidBegin)
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        createUI()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createUI() {

        setStatusButton = newButtonText("show status", #selector(getStatusPressed))

        [
            avatarImageView,
            fullNameLabel,
            profileWait,
            statusLabel,
            setStatusButton!,
        ].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    private func layout() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 96),
            avatarImageView.heightAnchor.constraint(equalToConstant: 96),

            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),

            profileWait.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 8),
            profileWait.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),

            statusLabel.heightAnchor.constraint(equalToConstant: 40),
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusLabel.topAnchor.constraint(equalTo: profileWait.bottomAnchor, constant: 8),

            setStatusButton!.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            setStatusButton!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            setStatusButton!.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
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
