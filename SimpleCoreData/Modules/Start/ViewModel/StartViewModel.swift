//
//  StartViewModel.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import Foundation

@objc protocol StartViewModelProtocol {
    @objc var coordinator: StartCoordinator? { get set }
    @objc func navigateToSubmit()
    @objc func getCompanyName() -> String?
}

class StartViewModel: NSObject, StartViewModelProtocol {
    weak var coordinator: StartCoordinator?

    private var companyRepository: CompanyRepositoryProtocol

    @objc init(companyRepository: CompanyRepositoryProtocol) {
        self.companyRepository = companyRepository
    }

    @objc func getCompanyName() -> String? {
        let company = companyRepository.fetchDefaultCompany()
        return company?.name
    }

    @objc func navigateToSubmit() {
        coordinator?.navigateToSubmit()
    }
}
