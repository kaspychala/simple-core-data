//
//  MockSubmitCoordinator.swift
//  SimpleCoreDataTests
//
//  Created by Kasper Spychala on 03/10/2024.
//

import Foundation

@testable import SimpleCoreData

class MockSubmitCoordinator: SubmitCoordinator {
    var didFinishCheckingInCalled = false

    override func didFinishCheckingIn() {
        didFinishCheckingInCalled = true
    }
}
