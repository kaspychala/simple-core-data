//
//  SubmitViewModelSpec.swift
//  SimpleCoreDataTests
//
//  Created by Kasper Spychala on 03/10/2024.
//

import Quick
import UIKit
import Nimble
@testable import SimpleCoreData

class SubmitViewModelSpec: QuickSpec {
    override class func spec() {
        var viewModel: SubmitViewModel!
        var mockEmployeeRepository: MockEmployeeRepository!
        var mockCompanyRepository: MockCompanyRepository!
        var mockNetworkingService: MockNetworkingService!
        var mockCoordinator: MockSubmitCoordinator!

        beforeEach {
            mockEmployeeRepository = MockEmployeeRepository()
            mockCompanyRepository = MockCompanyRepository()
            mockNetworkingService = MockNetworkingService()
            mockCoordinator = MockSubmitCoordinator(navigationController: UINavigationController())

            viewModel = SubmitViewModel(
                employeeRepository: mockEmployeeRepository,
                companyRepository: mockCompanyRepository,
                networkingService: mockNetworkingService
            )
            viewModel.coordinator = mockCoordinator
        }

        describe("insertCheckInDate") {
            it("should insert the check-in date when the date is valid") {
                let validDate = Date()
                viewModel.submitModel.selectedDate = validDate

                let mockCompany = Company(context: CoreDataHelper.shared.context)
                mockCompanyRepository.defaultCompany = mockCompany
                viewModel.insertCheckInDate()

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                let dateString = dateFormatter.string(from: validDate)

                expect(mockEmployeeRepository.insertedCheckInDate).to(equal(dateString))
            }

            it("should not insert the check-in date and show alert when the date is invalid") {
                let futureDate = Date().addingTimeInterval(3600) // 1 hour in the future
                viewModel.submitModel.selectedDate = futureDate

                viewModel.insertCheckInDate()

                expect(mockEmployeeRepository.insertedCheckInDate).to(beNil())
                expect(viewModel.submitModel.showAlert).to(beTrue())
            }
        }

        describe("getLatestCheckInDate") {
            context("when it's the first launch") {
                it("should fetch the latest check-in date from the network") {

                    waitUntil { done in
                        UserDefaultsManager.shared.resetFirstLaunch()
                        mockNetworkingService.mockCheckInDate = Date()

                        Task {
                            await viewModel.getLatestCheckInDate()
                            expect(viewModel.submitModel.selectedDate).to(equal(mockNetworkingService.mockCheckInDate))
                            done()
                        }
                    }
                }
            }

            context("when it's not the first launch") {
                it("should fetch the latest check-in date locally") {
                    let mockLatestDate = Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                    mockEmployeeRepository.latestCheckInDate = dateFormatter.string(from: mockLatestDate)

                    waitUntil { done in
                        Task {
                            await viewModel.getLatestCheckInDate()
                            expect(dateFormatter.string(from: viewModel.submitModel.selectedDate)).to(equal(dateFormatter.string(from: mockLatestDate)))
                            done()
                        }
                    }


                }
            }
        }

        describe("didFinishCheckingIn") {
            it("should call didFinishCheckingIn on the coordinator") {
                viewModel.didFinishCheckingIn()
                expect(mockCoordinator.didFinishCheckingInCalled).to(beTrue())
            }
        }
    }
}
