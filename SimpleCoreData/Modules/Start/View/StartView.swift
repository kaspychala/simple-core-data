//
//  StartView.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import UIKit

@objc class StartView: UIView {
    @objc var onButtonTap: (() -> Void)?

    @objc let companyNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    @objc let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(companyNameLabel)
        addSubview(startButton)
        NSLayoutConstraint.activate([
            companyNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            companyNameLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -20),

            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }

    @objc required init?(coder: NSCoder) {
        fatalError("Storyboards are not compatible with truth and beauty.")
    }

    @objc private func startButtonTapped() {
        onButtonTap?()
    }

    @objc func updateCompanyName(name: String) {
        companyNameLabel.text = "Welcome to \(name)"
    }
}


