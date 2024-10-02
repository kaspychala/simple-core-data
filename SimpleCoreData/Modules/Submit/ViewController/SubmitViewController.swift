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
    private let contentView: UIHostingController = {
        let hostingController = UIHostingController(rootView: SubmitView())
        return hostingController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        super.loadView()
        self.view = UIView()
        self.view.backgroundColor = .white
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
