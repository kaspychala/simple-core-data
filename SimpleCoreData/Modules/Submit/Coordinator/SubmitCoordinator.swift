//
//  SubmitCoordinator.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import UIKit

class SubmitCoordinator: Coordinator {
    weak var parentCoordinator: StartCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let employeeRepository: EmployeeRepositoryProtocol = EmployeeRepository()
        var viewModel = SubmitViewModel(employeeRepository: employeeRepository)
        viewModel.coordinator = self
        let viewController = SubmitViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
