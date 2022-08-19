//
//  navigationProfile.swift
//  Navigation
//
//  Created by Александр Лебедев on 20.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {



    private lazy var profileView = ProfileView(delegate: self)
    private let nc = NotificationCenter.default
    private var images = [UIImage]()
    private var avatar: UIImageView?

    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        profileView.setTableViewDelegate(self, self)
        profileView.profileHeaderView.delegate = self
        

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        title = "Profile"
        view.backgroundColor = .systemGray6
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nc.addObserver(self, selector: #selector(kdbShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kdbHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        nc.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @objc
    private func kdbShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let edgeInsets: UIEdgeInsets = .init(top: 0, left: 0, bottom: kbdSize.height - view.safeAreaInsets.bottom, right: 0)
            profileView.tableView.contentInset = edgeInsets
            profileView.tableView.scrollIndicatorInsets = edgeInsets
        }
    }

    @objc
    private func kdbHide() {
        profileView.tableView.contentInset = .zero
        profileView.tableView.verticalScrollIndicatorInsets = .zero
    }

    @objc
    private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        if let textField = profileView.profileHeaderView.textEditingChanged {
            textField.resignFirstResponder()
        }
    }

}

extension ProfileViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension ProfileViewController: UITableViewDataSource, PhotosTableViewCellDelegate{
    
    func buttonPhotoGallery() {
        navigationController?.pushViewController(PhotosViewController(), animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.item == 0 {
            let cell = PhotosTableViewCell(self)
            cell.setCollectionViewDelegate(delegate: self, dataSource: self)
            return cell
        } else {
            return PostTableViewCell(style: .default, reuseIdentifier: nil, post: posts[indexPath.row])
        }
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width: CGFloat = (collectionView.bounds.width - 8 * 3 - 12 * 2) / 4
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: (24 + 12 + 12), left: 12, bottom: 12, right: 12)
    }

}

extension ProfileViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) 
        -> Int {
            (1...20).forEach {
                if let image = UIImage(named: "cat_\($0)") {
                    images.append(image)
                }
            }
            return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.idintifier, for: indexPath) as! ProfileCollectionViewCell
        cell.photo.image = images[indexPath.item]
        cell.createUI()
        cell.layout()
        return cell
    }
}

extension ProfileViewController: ProfileHeaderViewDelegate, ProfileViewDelegate {

    func handleOpenPhoto() {

        avatar = profileView.profileHeaderView.createAvatar()
        avatar?.isUserInteractionEnabled = false
        profileView.profileHeaderView.avatar!.isHidden = true
        let width = profileView.profileHeaderView.avatar!.bounds.width
        let origin = profileView.profileHeaderView.avatar!.frame.origin
        let globalRect = view.convert(profileView.profileHeaderView.avatar!.bounds, to: profileView.profileHeaderView.avatar!.superview)
        avatar!.frame = CGRect(x: globalRect.origin.x + origin.x, y: -globalRect.origin.y + origin.y, width: width, height: width)
        view.addSubview(avatar!)

        UIView.animate(withDuration: 0.5, animations: { [self] in
            profileView.backgroundView.isHidden = false
            profileView.backgroundView.alpha = 0.5
            avatar!.layer.cornerRadius = 0
            avatar!.layer.borderWidth = 3 / profileView.frame.width * width
            avatar!.transform = CGAffineTransform(
                translationX: profileView.center.x - avatar!.center.x,
                y:  profileView.center.y - avatar!.center.y
            ).scaledBy(x: 1 / width * profileView.frame.width, y: 1 / width * profileView.frame.width)

        }, completion: { [self]_ in
            profileView.buttonClose.isHidden = false
            UIView.animate(withDuration: 0.3){ [self] in
                profileView.buttonClose.alpha = 1
            }
        })
    }

    func handleButtonClosePhoto() {
        UIView.animate(withDuration: 0.3, animations: { [self] in
            profileView.buttonClose.alpha = 0
        }, completion: { [self]_ in
            profileView.buttonClose.isHidden = true
            UIView.animate(withDuration: 0.5, animations: { [self] in
                profileView.backgroundView.alpha = 0
                avatar!.layer.cornerRadius = 96 / 2
                avatar!.layer.borderWidth = 3
                avatar!.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: { [self]_ in
                profileView.backgroundView.isHidden = true
                avatar?.removeFromSuperview()
                profileView.profileHeaderView.avatar!.isHidden = false
            })
        })
    }
}


