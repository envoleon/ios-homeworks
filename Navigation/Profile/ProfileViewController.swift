//
//  navigationProfile.swift
//  Navigation
//
//  Created by Александр Лебедев on 20.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    private let posts = [
        Post(title: "Время жрачки",
             author: "Кот",
             description: "Жду когда хозяин отвернется, что-бы успеть сожрать у собаки",
             image: "post.1",
             likes: 100000,
             views: 567688),
        Post(title: "Живу по кайфу",
             author: "Кот",
             description: "Занял стул хозяина, даю напоминать, что важнее его работы, только я",
             image: "post.2",
             likes: 57657,
             views: 67887),
        Post(title: "Валяюсь",
             author: "Кот",
             description: "Красивый, да?)",
             image: "post.3",
             likes: -5,
             views: 66),
        Post(title: "Очень интересно",
             author: "Кот",
             description: "...",
             image: "post.4",
             likes: 999,
             views: 9977),
    ]
    private let nc = NotificationCenter.default

    private let scrollView: UIScrollView = UIScrollView()
    private let contentView: UIView = UIView()
    private let subview: ProfileHeaderView = ProfileHeaderView()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "345")
        tableView.tableHeaderView = subview
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
        addConstraint()

        title = "Profile"
        view.backgroundColor = .systemGray6
    }

    private func createUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        view.addGestureRecognizer(tapGesture)

        [
            scrollView,
            contentView,
            tableView,
        ].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        tableView.tableHeaderView!.frame.size.height = 220
        view.addSubview(tableView)
    }

    private func addConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
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
}

extension ProfileViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        PostTableViewCell(style: .default, reuseIdentifier: nil, post: posts[indexPath.row])
    }
}
