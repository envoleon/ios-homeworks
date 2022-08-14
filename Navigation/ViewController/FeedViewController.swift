//
//  navigationTape.swift
//  Navigation
//
//  Created by Александр Лебедев on 20.05.2022.
//

import UIKit

class FeedViewController: UIViewController {

    private let post = Post(title: "Hello my friend")
    private var pushPostStackView: UIStackView?

    private lazy var buttonPostView: (String) -> UIButton = {
        let button = UIButton()
        let fontAttributes = [NSAttributedString.Key.font: button.titleLabel?.font]
        let size = ($0 as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
        button.setTitle($0, for: .normal)
        button.setTitleColor(UIColor(named: "bar-color"), for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemYellow.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.handleButtonTab), for: .touchUpInside)

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: size.width + 20),
            button.heightAnchor.constraint(equalToConstant: size.height + 10)
        ])

        return button
    }

    private let postStackView: ([UIView]) -> UIStackView = {
        let stackView = UIStackView(arrangedSubviews: $0)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
        layout()

        title = "Feed"
        view.backgroundColor = .systemBackground
    }

    private func createUI() {
        pushPostStackView = postStackView([
            buttonPostView("...Go to the post"),
            buttonPostView("...Go to the post var 2")
        ])

        view.addSubview(pushPostStackView!)
    }

    private func layout() {
        NSLayoutConstraint.activate([
            pushPostStackView!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pushPostStackView!.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc
    private func handleButtonTab() {
        PostViewController().postTitle = post
        navigationController?.pushViewController(PostViewController(), animated: true)
    }
}
