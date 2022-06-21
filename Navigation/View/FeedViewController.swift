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
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleButtonTab), for: .touchUpInside)

        let fontAttributes = [NSAttributedString.Key.font: button.titleLabel?.font]
        let size = ("...Go to the post" as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: size.width + 20),
            button.heightAnchor.constraint(equalToConstant: size.height + 10)
        ])

        return button
    }()

    let post = Post(title: "Hello my friend")

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()

        title = "Feed"
        view.backgroundColor = .systemBackground
    }

    func createUI() {
        view.addSubview(buttonPostView)
        
        NSLayoutConstraint.activate([
            buttonPostView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonPostView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

    @objc
    func handleButtonTab() {
        PostViewController().postTitle = post
        navigationController?.pushViewController(PostViewController(), animated: true)
    }
}
