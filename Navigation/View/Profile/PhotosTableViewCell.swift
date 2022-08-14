//
//  PhotosTableViewCell.swift
//  Navigation CollectionView
//
//  Created by Александр Лебедев on 09.08.2022.
//

import UIKit

protocol PhotosTableViewCellDelegate: AnyObject {
    func buttonPhotoGallery()
}

class PhotosTableViewCell: UITableViewCell {
    weak var delegate: PhotosTableViewCellDelegate?

    private let title: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private lazy var buttonRight: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleButtonPhotoGallery), for: .touchUpInside)
        return button
    }()

    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.separator
        return view
    }()

    var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.idintifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    init(_ delegate: PhotosTableViewCellDelegate?) {
        self.delegate = delegate
        super.init(style: .default, reuseIdentifier: .none)
        backgroundColor = .none
        let bgColorView = UIView()
        bgColorView.backgroundColor = .none
        selectedBackgroundView = bgColorView
        separatorInset.left = 0

        createUI()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createUI() {
        [
            //title,
            //buttonRight,
            collectionView,
            separator
        ].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        [
            title,
            buttonRight,
        ].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
            collectionView.addSubview($0)
        }
    }

    private func layout() {

        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),

            buttonRight.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            buttonRight.centerYAnchor.constraint(equalTo: title.centerYAnchor),

            collectionView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 8 * 3 - 12 * 2) / 4 + 12 * 2 + (24 + 12)),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),

            separator.heightAnchor.constraint(equalToConstant: 1 / 3),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }

    func setCollectionViewDelegate(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }

    @objc
    private func handleButtonPhotoGallery() {
        delegate?.buttonPhotoGallery()
    }

}
