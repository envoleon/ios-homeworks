//
//  ProfileCollectionViewCell.swift
//  Navigation CollectionView
//
//  Created by Александр Лебедев on 09.08.2022.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {

    static var idintifier: String {
        String(describing: self)
    }
    var indexPhoto: Int?

    private let photo: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createUI() {
        [
            photo
        ].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        photo.image = UIImage(named: "cat_\(indexPhoto! + 1)")
    }

    func layout() {
        NSLayoutConstraint.activate([
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

}
