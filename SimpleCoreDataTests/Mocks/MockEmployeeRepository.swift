//
//  MockEmployeeRepository.swift
//  SimpleCoreDataTests
//
//  Created by Kasper Spychala on 03/10/2024.
//

import Foundation

@testable import SimpleCoreData

class MockEmployeeRepository: EmployeeRepositoryProtocol {
    var insertedCheckInDate: String?
    var latestCheckInDate: String?
    var employeesForCompany: [Employee] = []

    func insertCheckInDate(_ date: String, forCompany company: Company) {
        insertedCheckInDate = date
    }

    func fetchLatestCheckInDate() -> String? {
        return latestCheckInDate
    }

    func fetchEmployees(forCompany company: Company) -> [Employee] {
        return employeesForCompany
    }
}
