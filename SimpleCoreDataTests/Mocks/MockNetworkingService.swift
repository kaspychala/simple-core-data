//
//  MockNetworkingService.swift
//  SimpleCoreDataTests
//
//  Created by Kasper Spychala on 03/10/2024.
//

import Foundation

@testable import SimpleCoreData

class MockNetworkingService: NetworkingServiceProtocol {
    var mockCheckInDate: Date?
    var shouldThrowError = false

    func fetchCheckInDateTime() async throws -> Date? {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        return mockCheckInDate
    }
}
