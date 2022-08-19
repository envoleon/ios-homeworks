//
//  PhotosViewController.swift
//  Navigation CollectionView
//
//  Created by Александр Лебедев on 14.08.2022.
//

import UIKit

class PhotosViewController: UIViewController {

    private var images = [UIImage]()

    private lazy var photosCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.idintifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
        layout()

        title = "Photo Gallery"
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func createUI() {
        [photosCollection].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    private func layout() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            photosCollection.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            photosCollection.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            photosCollection.topAnchor.constraint(equalTo: safeArea.topAnchor),
            photosCollection.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width: CGFloat = (collectionView.bounds.width - 8 * 4) / 3
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

}

extension PhotosViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        (1...20).forEach {
            if let image = UIImage(named: "cat_\($0)") {
                images.append(image)
            }
        }
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.idintifier, for: indexPath) as! PhotosCollectionViewCell
        cell.photo.image = images[indexPath.item]
        cell.createUI()
        cell.layout()
        return cell
    }
}
