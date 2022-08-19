//
//  ProfileView.swift
//  Navigation CollectionView
//
//  Created by Александр Лебедев on 09.08.2022.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func handleButtonClosePhoto()
}

class ProfileView: UIView {

    weak var delegate: ProfileViewDelegate?

    let profileHeaderView = ProfileHeaderView()

    lazy var backgroundView: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.backgroundColor = .black
        view.alpha = 0
        view.isHidden = true
        return view
    }()

    lazy var buttonClose: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.alpha = 0
        button.addTarget(self, action: #selector(handleButtonClosePhoto), for: .touchUpInside)
        button.isHidden = true
        return button
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemGray6
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "345")
        tableView.tableHeaderView = profileHeaderView
        tableView.tableHeaderView!.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView!.frame.size.height = 220
        return tableView
    }()

    init(delegate: ProfileViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)

        createUI()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createUI() {
        [
            tableView,
            backgroundView,
            buttonClose
        ].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    private func layout() {
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            tableView.tableHeaderView!.heightAnchor.constraint(equalToConstant: 220),
            tableView.tableHeaderView!.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            tableView.tableHeaderView!.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            tableView.tableHeaderView!.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),

            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),

            buttonClose.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            buttonClose.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
        ])
    }

    func setTableViewDelegate(_ delegate: UITableViewDelegate, _ dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }

    @objc
    private func handleButtonClosePhoto() {
        delegate?.handleButtonClosePhoto()
    }
}

