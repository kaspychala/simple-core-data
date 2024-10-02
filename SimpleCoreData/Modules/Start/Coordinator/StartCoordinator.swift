//
//  StartCoordinator.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import UIKit

class StartCoordinator: Coordinator {
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    func start() {
        var viewModel: StartViewModelProtocol = StartViewModel()
        viewModel.coordinator = self
        let viewController = StartViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: false)
    }

    func navigateToSubmit() {
        let child = SubmitCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
}
