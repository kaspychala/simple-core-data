//
//  CompanyRepository.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 03/10/2024.
//

import CoreData

@objc protocol CompanyRepositoryProtocol {
    @objc func insertCompany(name: String)
    @objc func fetchCompany(forName name: String) -> Company?
    @objc func fetchDefaultCompany() -> Company?
}

class CompanyRepository: NSObject, CompanyRepositoryProtocol {
    private let context: NSManagedObjectContext

    @objc init(context: NSManagedObjectContext = CoreDataHelper.shared.context) {
        self.context = context
    }

    @objc func insertCompany(name: String) {
        let company = Company(context: context)
        company.name = name

        do {
            try context.save()
            LoggingManager.shared.info("Successfully saved company: \(name)")
        } catch {
            LoggingManager.shared.error("Failed to save company: \(error)")
        }
    }

    @objc func fetchDefaultCompany() -> Company? {
        let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", "Migration Company")

        do {
            let companies = try context.fetch(fetchRequest)
            if let defaultCompany = companies.first {
                return defaultCompany
            } else {
                LoggingManager.shared.error("Default company not found")
                return nil
            }
        } catch {
            LoggingManager.shared.error("Failed to fetch default company: \(error)")
            return nil
        }
    }

    @objc func fetchCompany(forName name: String) -> Company? {
        let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let companies = try context.fetch(fetchRequest)
            if let company = companies.first {
                return company
            } else {
                LoggingManager.shared.error("Company with name \(name) not found")
                return nil
            }
        } catch {
            LoggingManager.shared.error("Failed to fetch company with name \(name): \(error)")
            return nil
        }
    }
}
