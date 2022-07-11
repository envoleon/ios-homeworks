//
//  navigationProfile.swift
//  Navigation
//
//  Created by Александр Лебедев on 20.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    private let nc = NotificationCenter.default
    
    private let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())

    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    private let subview: ProfileHeaderView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(ProfileHeaderView())

    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()

        title = "Profile"
        view.backgroundColor = .lightGray
    }

    private func createUI() {

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        view.addGestureRecognizer(tapGesture)

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(subview)
        let setTitleButton = subview.newButtonText("set title", #selector(getTitlePressed))
        contentView.addSubview(setTitleButton)

        let margins = contentView.layoutMarginsGuide
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

            subview.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            subview.topAnchor.constraint(equalTo: contentView.topAnchor),
            subview.heightAnchor.constraint(equalToConstant: 220),

            setTitleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            setTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            setTitleButton.topAnchor.constraint(equalTo: subview.bottomAnchor, constant: 150),
            setTitleButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            setTitleButton.heightAnchor.constraint(equalToConstant: 50)

            
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
        if let textField = subview.textEditingChanged {
            textField.resignFirstResponder()
        }
    }

    @objc
    private func getTitlePressed() {
        if let text = subview.statusLabel.text {
            if (text.count > 0) {
                title = text
                print(text)
            }
        }
    }
}
