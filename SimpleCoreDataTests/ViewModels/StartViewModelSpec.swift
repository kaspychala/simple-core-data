//
//  StartViewModelSpec.swift
//  SimpleCoreDataTests
//
//  Created by Kasper Spychala on 03/10/2024.
//

import Quick
import Nimble
import UIKit
@testable import SimpleCoreData

class StartViewModelSpec: QuickSpec {
    override class func spec() {
        var viewModel: StartViewModel!
        var mockCompanyRepository: MockCompanyRepository!
        var mockCoordinator: MockStartCoordinator!

        beforeEach {
            mockCompanyRepository = MockCompanyRepository()
            mockCoordinator = MockStartCoordinator(navigationController: UINavigationController())
            viewModel = StartViewModel(companyRepository: mockCompanyRepository)
            viewModel.coordinator = mockCoordinator
        }

        describe("getCompanyName") {
            it("should return the company name from the repository") {
                let mockCompany = Company(context: CoreDataHelper.shared.context)
                mockCompany.name = "Test Company"
                mockCompanyRepository.defaultCompany = mockCompany

                let companyName = viewModel.getCompanyName()
                expect(companyName).to(equal("Test Company"))
            }

            it("should return nil when no company is found") {
                mockCompanyRepository.defaultCompany = nil
                let companyName = viewModel.getCompanyName()
                expect(companyName).to(beNil())
            }
        }

        describe("navigateToSubmit") {
            it("should call navigateToSubmit on the coordinator") {
                viewModel.navigateToSubmit()
                expect(mockCoordinator.didNavigateToSubmit).to(beTrue())
            }
        }
    }
}
