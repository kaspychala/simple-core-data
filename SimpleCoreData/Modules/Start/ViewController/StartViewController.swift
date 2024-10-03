//
//  StartViewController.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import UIKit

class StartViewController: UIViewController {
    var viewModel: StartViewModelProtocol?
    private let contentView: StartView = {
        let view = StartView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        handleButton()
        updateCompanyName()
    }

    private func updateCompanyName() {
        guard let companyName = viewModel?.getCompanyName() else {
            LoggingManager.shared.error("Company name not accessible")
            return
        }
        contentView.updateCompanyName(name: companyName)
    }

    private func handleButton() {
        contentView.onButtonTap = { [weak self] in
            guard let self = self else { return }
            self.viewModel?.navigateToSubmit()
        }
    }

    override func loadView() {
        super.loadView()
        self.view = UIView()
        self.view.backgroundColor = .white
        self.view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor
            ),
            contentView.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor
            ),
            contentView.leadingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.leadingAnchor
            ),
            contentView.trailingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.trailingAnchor
            )
        ])
    }
}

