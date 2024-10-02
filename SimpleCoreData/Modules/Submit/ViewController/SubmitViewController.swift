//
//  SubmitViewController.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import UIKit
import SwiftUI

class SubmitViewController: UIViewController {
    var viewModel: SubmitViewModelProtocol?
    lazy var contentView: UIHostingController<SubmitView>? = {
        guard let viewModel = viewModel else { return nil }
        let hostingController = UIHostingController(rootView: SubmitView(model: viewModel.submitModel))
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        handleButton()
        Task {
            await getLatestCheckInDate()
        }
    }

    private func handleButton() {
        contentView?.rootView.onButtonTap = { [weak self] in
            guard let self else { return }
            self.viewModel?.insertCheckInDate()
        }
    }

    private func getLatestCheckInDate() async {
        await viewModel?.getLatestCheckInDate()
    }

    override func loadView() {
        super.loadView()
        self.view = UIView()
        self.view.backgroundColor = .white
        guard let contentView = contentView else {
            LoggingManager.shared.error("UIHostingController not set")
            return
        }
        self.addChild(contentView)
        self.view.addSubview(contentView.view)
        NSLayoutConstraint.activate([
            contentView.view.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor
            ),
            contentView.view.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor
            ),
            contentView.view.leadingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.leadingAnchor
            ),
            contentView.view.trailingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.trailingAnchor
            )
        ])
    }
}
