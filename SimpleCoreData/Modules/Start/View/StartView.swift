//
//  StartView.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import UIKit

class StartView: UIView {
    var onButtonTap: (() -> Void)?

    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("Storyboards are not compatible with truth and beauty.")
    }

    // Handle button tap and call the closure
    @objc private func startButtonTapped() {
        onButtonTap?()
    }
}


