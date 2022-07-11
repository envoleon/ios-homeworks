//
//  InfoViewController.swift
//  Navigation
//
//  Created by Александр Лебедев on 22.05.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var buttonPostView: UIButton = {
        $0.setTitle("Alert", for: .normal)
        $0.setTitleColor(UIColor(named: "bar-color"), for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemYellow.cgColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(handleButtonTab), for: .touchUpInside)

        let fontAttributes = [NSAttributedString.Key.font: $0.titleLabel?.font]
        let size = ("Alert" as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])

        NSLayoutConstraint.activate([
            $0.widthAnchor.constraint(equalToConstant: size.width + 20),
            $0.heightAnchor.constraint(equalToConstant: size.height + 10)
        ])

        return $0
    }(UIButton())

    private let alert: UIAlertController = {
        $0.addAction(UIAlertAction(
            title: "red",
            style: .default,
            handler: { _ in print("welcome") }
        ))
        $0.addAction(UIAlertAction(
            title: "blue",
            style: .default,
            handler: { _ in print("goodbye") }
        ))
        return $0
    }(UIAlertController(
        title: "Choose red or blue pill",
        message: nil,
        preferredStyle: .alert
    ))

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()

        view.backgroundColor = .systemBackground
    }

    private func createUI() {
        view.addSubview(buttonPostView)

        NSLayoutConstraint.activate([
            buttonPostView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonPostView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

    @objc
    private func handleButtonTab() { present(alert, animated: true, completion: nil) }
}
