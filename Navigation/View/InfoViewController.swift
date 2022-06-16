//
//  InfoViewController.swift
//  Navigation
//
//  Created by Александр Лебедев on 22.05.2022.
//

import UIKit

class InfoViewController: UIViewController {

    let buttonPostView: UIButton = {
        let button = UIButton()
        button.setTitle("Alert", for: .normal)
        button.setTitleColor(UIColor(named: "bar-color"), for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemYellow.cgColor
        button.addTarget(self, action: #selector(handleButtonTab), for: .touchUpInside)

        let fontAttributes = [NSAttributedString.Key.font: button.titleLabel?.font]
        let size = ("Alert" as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])

        button.frame.size = CGSize(
            width: size.width + 20,
            height: size.height + 10
        )

        return button
    }()

    let alert: UIAlertController = {
        let alertController = UIAlertController(
            title: "Choose red or blue pill",
            message: nil,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(
            title: "red",
            style: .default,
            handler: { _ in print("welcome") }
        ))
        alertController.addAction(UIAlertAction(
            title: "blue",
            style: .default,
            handler: { _ in print("goodbye") }
        ))
        return alertController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(buttonPostView)
    }

    // Знаю что можно через констейнты, просто хотел попрробовать вручную
    override func viewDidLayoutSubviews() { reSize() }

    func reSize() {
        buttonPostView.frame.origin = CGPoint(
            x: (view.frame.width - buttonPostView.frame.width) / 2,
            y: (view.frame.height - buttonPostView.frame.height) / 2
        )
    }

    @objc
    func handleButtonTab() { present(alert, animated: true, completion: nil) }
}
