//
//  PhotosCollectionViewCell.swift
//  Navigation CollectionView
//
//  Created by Александр Лебедев on 14.08.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    static var idintifier: String {
        String(describing: self)
    }
    
    let photo: UIImageView = {
        let imageView = UIImageView()
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
