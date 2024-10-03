//
//  SubmitViewModel.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import Foundation

protocol SubmitViewModelProtocol {
    var coordinator: SubmitCoordinator? { get set }
    var submitModel: SubmitModel { get }
    func insertCheckInDate()
    func didFinishCheckingIn()
    func getLatestCheckInDate() async
}

class SubmitViewModel: SubmitViewModelProtocol {
    weak var coordinator: SubmitCoordinator?

    private var employeeRepository: EmployeeRepositoryProtocol
    private var companyRepository: CompanyRepositoryProtocol
    private var networkingService: NetworkingServiceProtocol
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }

    var submitModel: SubmitModel = SubmitModel()

    init(
        employeeRepository: EmployeeRepositoryProtocol,
        companyRepository: CompanyRepositoryProtocol,
        networkingService: NetworkingServiceProtocol
    ) {
        self.employeeRepository = employeeRepository
        self.companyRepository = companyRepository
        self.networkingService = networkingService
    }

    func insertCheckInDate() {
        if validateDate(date: submitModel.selectedDate) {
            let dateString = dateFormatter.string(from: submitModel.selectedDate)
            guard let company = companyRepository.fetchDefaultCompany() else {
                return
            }
            employeeRepository.insertCheckInDate(dateString, forCompany: company)
        } else {
            submitModel.showAlert.toggle()
        }

    }

    func didFinishCheckingIn() {
        coordinator?.didFinishCheckingIn()
    }

    @MainActor
    func getLatestCheckInDate() async {
        if UserDefaultsManager.shared.isFirstLaunch() {
            await getRemoteLatestCheckInDate()
        } else {
            getLocalLatestCheckInDate()
        }
    }

    private func getLocalLatestCheckInDate() {
        guard let latestCheckInDateString = employeeRepository.fetchLatestCheckInDate(),
              let latestCheckInDate = dateFormatter.date(from: latestCheckInDateString) else {
            return
        }
        self.submitModel.selectedDate = latestCheckInDate
    }

    @MainActor
    private func getRemoteLatestCheckInDate() async {
        do {
            submitModel.isLoading.toggle()
            if let date = try await networkingService.fetchCheckInDateTime() {
                self.submitModel.selectedDate = date
            }
            submitModel.isLoading.toggle()
        } catch {
            LoggingManager.shared.error("Failed to fetch mock API data: \(error)")
            submitModel.isLoading.toggle()
        }
    }

    private func validateDate(date: Date) -> Bool {
        return date <= Date()
    }
}
