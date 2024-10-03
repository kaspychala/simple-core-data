//
//  StartCoordinator.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import UIKit

@objc class StartCoordinator: NSObject, Coordinator {
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    @objc init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    @objc func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    @objc func start() {
        let companyRepository: CompanyRepositoryProtocol = CompanyRepository()
        let viewModel: StartViewModelProtocol = StartViewModel(companyRepository: companyRepository)
        viewModel.coordinator = self
        let viewController = StartViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: false)
    }

    @objc func navigateToSubmit() {
        let child = SubmitCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
}
