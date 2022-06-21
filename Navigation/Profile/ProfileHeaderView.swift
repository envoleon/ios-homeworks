//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Александр Лебедев on 24.05.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    let profileImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profile-image"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 96 / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        return imageView
    }()

    let profileName: UILabel = {
        let label = UILabel()
        label.text = "The cat is dumb"
        label.font? = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let buttonStatus: UIButton = {
        let button = UIButton()
        button.setTitle("show status", for: .normal)
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
        button.addTarget(self, action: #selector(getStatusPressed), for: .touchUpInside)
        return button
    }()

    let profileWait: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.font? = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let textStatus: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font? = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        return textField
    }()
    private var statusText: String?

    override init(frame: CGRect) {
        super.init(frame: frame)

        createUI()
    }

    func createUI() {
        addSubview(profileImage)
        addSubview(profileName)
        addSubview(buttonStatus)
        addSubview(profileWait)
        addSubview(textStatus)

        let margins = self.layoutMarginsGuide
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: margins.topAnchor, constant: 16),
            profileImage.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16),
            profileImage.widthAnchor.constraint(equalToConstant: 96),
            profileImage.heightAnchor.constraint(equalToConstant: 96),

            profileName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 16),
            profileName.topAnchor.constraint(equalTo: margins.topAnchor, constant: 27),

            buttonStatus.heightAnchor.constraint(equalToConstant: 50),
            buttonStatus.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16),
            buttonStatus.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16),
            buttonStatus.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16),

            profileWait.bottomAnchor.constraint(equalTo: textStatus.topAnchor, constant: -8),
            profileWait.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 16),

            textStatus.heightAnchor.constraint(equalToConstant: 40),
            textStatus.bottomAnchor.constraint(equalTo: buttonStatus.topAnchor, constant: -16),
            textStatus.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 16),
            textStatus.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func getStatusPressed() {
        profileWait.text = statusText ?? ""
        print(profileWait.text!)
    }

    @objc
    func statusTextChanged(_ textField: UITextField) {
        statusText = textStatus.text
    }
}
