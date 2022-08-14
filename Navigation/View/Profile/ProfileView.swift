//
//  ProfileView.swift
//  Navigation CollectionView
//
//  Created by Александр Лебедев on 09.08.2022.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {}

class ProfileView: UIView {

    weak var delegate: ProfileViewDelegate?

    let profileHeaderView = ProfileHeaderView()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemGray6
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "345")
        tableView.tableHeaderView = profileHeaderView
        tableView.tableHeaderView!.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView!.frame.size.height = 220
        return tableView
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
        [
            tableView,
        ].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    private func layout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            tableView.tableHeaderView!.heightAnchor.constraint(equalToConstant: 220),
            tableView.tableHeaderView!.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            tableView.tableHeaderView!.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            tableView.tableHeaderView!.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
        ])
    }

    func setTableViewDelegate(_ delegate: UITableViewDelegate, _ dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
}

