//
//  SubmitModel.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import Foundation

class SubmitModel: ObservableObject {
    @Published var selectedDate: Date = .init()
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = false
}
