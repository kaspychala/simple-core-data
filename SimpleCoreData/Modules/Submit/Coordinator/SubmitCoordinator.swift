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
        let companyRepository: CompanyRepositoryProtocol = CompanyRepository()
        let networkingService: NetworkingServiceProtocol = NetworkingService()
        let viewModel = SubmitViewModel(
            employeeRepository: employeeRepository,
            companyRepository: companyRepository,
            networkingService: networkingService)
        viewModel.coordinator = self
        let viewController = SubmitViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }

    func didFinishCheckingIn() {
        parentCoordinator?.childDidFinish(self)
    }
}
