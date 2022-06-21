//
//  navigationProfile.swift
//  Navigation
//
//  Created by Александр Лебедев on 20.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    let subview = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(subview)

        title = "Profile"
        view.backgroundColor = .lightGray
    }


    override func viewWillLayoutSubviews() {
        subview.frame = view.frame
    }
}
