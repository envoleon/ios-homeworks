//
//  ViewController.swift
//  Navigation
//
//  Created by Александр Лебедев on 20.05.2022.
//

import UIKit

class PostViewController: UIViewController {

    var postTitle: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = barButtonItem()
    }

    func barButtonItem() -> UIBarButtonItem  {
        let buttonItem = UIBarButtonItem()
        buttonItem.title = "Info"
        buttonItem.style = .plain
        buttonItem.target = self
        buttonItem.action = #selector(barButtonItemTapped(_:))
        return buttonItem
    }

    @objc func barButtonItemTapped(_ sender:UIBarButtonItem!) {
        navigationController?.present(InfoViewController(), animated: true, completion: nil)
    }
}

