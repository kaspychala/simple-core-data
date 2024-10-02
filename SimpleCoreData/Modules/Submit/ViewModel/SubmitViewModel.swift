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
    func getLatestCheckInDate()
}

class SubmitViewModel: SubmitViewModelProtocol {
    weak var coordinator: SubmitCoordinator?

    private var employeeRepository: EmployeeRepositoryProtocol
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }

    var submitModel: SubmitModel = SubmitModel()

    init(employeeRepository: EmployeeRepositoryProtocol) {
        self.employeeRepository = employeeRepository
    }

    func insertCheckInDate() {
        if validateDate(date: submitModel.selectedDate) {
            let dateString = dateFormatter.string(from: submitModel.selectedDate)
            employeeRepository.insertCheckInDate(dateString)
        } else {
            submitModel.showAlert.toggle()
        }

    }

    func getLatestCheckInDate() {
        guard let latestCheckInDateString = employeeRepository.fetchLatestCheckInDate(),
              let latestCheckInDate = dateFormatter.date(from: latestCheckInDateString) else {
            return
        }
        self.submitModel.selectedDate = latestCheckInDate
    }

    private func validateDate(date: Date) -> Bool {
        return date <= Date()
    }
}
