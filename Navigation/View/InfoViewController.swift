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
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleButtonTab), for: .touchUpInside)
        
        let fontAttributes = [NSAttributedString.Key.font: button.titleLabel?.font]
        let size = ("Alert" as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: size.width + 20),
            button.heightAnchor.constraint(equalToConstant: size.height + 10)
        ])

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
        createUI()

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
    func handleButtonTab() { present(alert, animated: true, completion: nil) }
}
