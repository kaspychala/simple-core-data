//
//  MockStartCoordinator.swift
//  SimpleCoreDataTests
//
//  Created by Kasper Spychala on 03/10/2024.
//

import Foundation

@testable import SimpleCoreData

class MockStartCoordinator: StartCoordinator {
    var didNavigateToSubmit = false

    override func navigateToSubmit() {
        didNavigateToSubmit = true
    }
}
