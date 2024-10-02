//
//  SubmitViewModel.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import Foundation

protocol SubmitViewModelProtocol {
    var coordinator: SubmitCoordinator? { get set }
    func addNewDate(date: Date)
}

class SubmitViewModel: SubmitViewModelProtocol {
    weak var coordinator: SubmitCoordinator?

    func addNewDate(date: Date) {
        print("TODO: Add new date")
    }
}
