//
//  navigationProfile.swift
//  Navigation
//
//  Created by Александр Лебедев on 20.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    let subview: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView()
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return profileHeaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()

        title = "Profile"
        view.backgroundColor = .lightGray
    }

    func createUI() {
        view.addSubview(subview)
        let setTitleButton = subview.newButtonText("set title", #selector(getTitlePressed))
        view.addSubview(setTitleButton)

        let margins = view.layoutMarginsGuide
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0),
            subview.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0),
            subview.topAnchor.constraint(equalTo: safeArea.topAnchor),
            subview.heightAnchor.constraint(equalToConstant: 220),

            setTitleButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            setTitleButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            setTitleButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }

    @objc
    func getTitlePressed() {
        if let text = subview.statusLabel.text {
            if (text.count > 0) {
                title = text
                print(text)
            }
        }
    }
}
