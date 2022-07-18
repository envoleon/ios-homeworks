//
//  PostTableViewCell.swift
//  Navigation Table v2
//
//  Created by Александр Лебедев on 13.07.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    var post: Post?

    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = post?.title
        label.font? = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        return label
    }()

    private lazy var imagePost: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: post!.image, in: nil, with: .none))
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .black
        return imageView
    }()

    private lazy var descriptionPost: UILabel = {
        let label = UILabel()
        label.text = post?.description
        label.font? = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()

    private lazy var likesPost: UILabel = {
        let label = UILabel()
        label.text = "Likes: \(post!.likes)"
        label.font? = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    private lazy var viewsPost: UILabel = {
        let label = UILabel()
        label.text = "Views: \(post!.views)"
        label.font? = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, post: Post) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.post = post

        createUI()
        addConstraint()

        contentView.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createUI() {
        [
            header,
            imagePost,
            descriptionPost,
            likesPost,
            viewsPost,

        ].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }

    private func addConstraint() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            header.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            imagePost.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 12),
            imagePost.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imagePost.heightAnchor.constraint(equalTo: imagePost.widthAnchor),

            descriptionPost.topAnchor.constraint(equalTo: imagePost.bottomAnchor, constant: 16),
            descriptionPost.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionPost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            likesPost.topAnchor.constraint(equalTo: descriptionPost.bottomAnchor, constant: 16),
            likesPost.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            viewsPost.topAnchor.constraint(equalTo: descriptionPost.bottomAnchor, constant: 16),
            viewsPost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewsPost.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

}
