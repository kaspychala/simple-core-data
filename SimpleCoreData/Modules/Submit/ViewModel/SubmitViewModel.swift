//
//  SubmitViewModel.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import Foundation

protocol SubmitViewModelProtocol {
    var coordinator: SubmitCoordinator? { get set }
}

class SubmitViewModel: SubmitViewModelProtocol {
    weak var coordinator: SubmitCoordinator?
}
