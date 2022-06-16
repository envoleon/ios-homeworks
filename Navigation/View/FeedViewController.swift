//
//  navigationTape.swift
//  Navigation
//
//  Created by Александр Лебедев on 20.05.2022.
//

import UIKit

class FeedViewController: UIViewController {

    let buttonPostView: UIButton = {
        let button = UIButton()
        button.setTitle("...Go to the post", for: .normal)
        button.setTitleColor(UIColor(named: "bar-color"), for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemYellow.cgColor
        button.addTarget(self, action: #selector(handleButtonTab), for: .touchUpInside)

        let fontAttributes = [NSAttributedString.Key.font: button.titleLabel?.font]
        let size = ("...Go to the post" as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])

        button.frame.size = CGSize(
            width: size.width + 20,
            height: size.height + 10
        )

        return button
    }()

    let post = Post(title: "Hello my friend")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(buttonPostView)

        title = "Feed"
        view.backgroundColor = .systemBackground
    }

    override func viewDidLayoutSubviews() { reSize() }

    func reSize() {
        buttonPostView.frame.origin = CGPoint(
            x: (view.frame.width - buttonPostView.frame.width) / 2,
            y: (view.frame.height - buttonPostView.frame.height) / 2
        )
    }

    @objc
    func handleButtonTab() {
        PostViewController().postTitle = post
        self.navigationController?.pushViewController(PostViewController(), animated: true)
    }
}
