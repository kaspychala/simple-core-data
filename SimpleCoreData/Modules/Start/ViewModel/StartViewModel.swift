//
//  StartViewModel.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import Foundation

protocol StartViewModelProtocol {
    var coordinator: StartCoordinator? { get set }
    func navigateToSubmit()
}

class StartViewModel: StartViewModelProtocol {
    weak var coordinator: StartCoordinator?

    func navigateToSubmit() {
        coordinator?.navigateToSubmit()
    }
}
