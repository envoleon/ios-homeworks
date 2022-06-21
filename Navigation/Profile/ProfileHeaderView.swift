//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Александр Лебедев on 24.05.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    let avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profile-image"))
        imageView.layer.cornerRadius = 96 / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "The cat is dumb"
        label.font? = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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

    let profileWait: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.font? = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let statusLabel: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font? = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(statusTextFieldChanged(_:)), for: .editingChanged)
        return textField
    }()

    private var statusTextField: String?

    override init(frame: CGRect) {
        super.init(frame: frame)

        createUI()
    }

    func createUI() {
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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func getStatusPressed() {
        if let text = statusTextField {
            profileWait.text = text
            print(profileWait.text!)
        }
    }

    @objc
    func statusTextFieldChanged(_ textField: UITextField) {
        statusTextField = statusLabel.text
    }
}
