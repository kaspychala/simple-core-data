//
//  UserDefaultsManager.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    func isFirstLaunch() -> Bool
    func resetFirstLaunch()
}

class UserDefaultsManager: UserDefaultsManagerProtocol {
    static let shared: UserDefaultsManagerProtocol = UserDefaultsManager()

    private let defaults = UserDefaults.standard
    private let hasLaunchedKey = "hasLaunchedBefore"

    private init() {}

    func isFirstLaunch() -> Bool {
        if defaults.bool(forKey: hasLaunchedKey) {
            return false
        } else {
            defaults.set(true, forKey: hasLaunchedKey)
            return true
        }
    }

    // Reset for testing purposes (optional, can be used to reset launch flag)
    func resetFirstLaunch() {
        defaults.set(false, forKey: hasLaunchedKey)
    }
}
