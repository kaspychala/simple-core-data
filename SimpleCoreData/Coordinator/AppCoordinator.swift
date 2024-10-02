//
//  AppCoordinator.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import Foundation

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let child = StartCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
}
