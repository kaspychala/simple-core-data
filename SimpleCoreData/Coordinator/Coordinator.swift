//
//  Coordinator.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import UIKit

@objc protocol Coordinator: AnyObject {
    @objc var childCoordinators: [Coordinator] { get set }
    @objc var navigationController: UINavigationController { get set }

    @objc func start()
}
