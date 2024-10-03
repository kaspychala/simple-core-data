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
    func getCompanyName() -> String?
}

class StartViewModel: StartViewModelProtocol {
    weak var coordinator: StartCoordinator?

    private var companyRepository: CompanyRepositoryProtocol

    init(companyRepository: CompanyRepositoryProtocol) {
        self.companyRepository = companyRepository
    }

    func getCompanyName() -> String? {
        let company = companyRepository.fetchDefaultCompany()
        return company?.name
    }

    func navigateToSubmit() {
        coordinator?.navigateToSubmit()
    }
}
