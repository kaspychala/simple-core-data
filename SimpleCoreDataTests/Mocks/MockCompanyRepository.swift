//
//  MockCompanyRepository.swift
//  SimpleCoreDataTests
//
//  Created by Kasper Spychala on 03/10/2024.
//

import Foundation

@testable import SimpleCoreData

class MockCompanyRepository: CompanyRepositoryProtocol {
    var insertedCompanyName: String?
    var defaultCompany: Company?

    func insertCompany(name: String) {
        insertedCompanyName = name
    }

    func fetchCompany(forName name: String) -> Company? {
        return defaultCompany
    }

    func fetchDefaultCompany() -> Company? {
        return defaultCompany
    }
}
 
