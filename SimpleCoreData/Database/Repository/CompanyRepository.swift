//
//  CompanyRepository.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 03/10/2024.
//

import CoreData

protocol CompanyRepositoryProtocol {
    func insertCompany(name: String)
    func fetchCompany(forName name: String) -> Company?
    func fetchDefaultCompany() -> Company?
}

class CompanyRepository: CompanyRepositoryProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataHelper.shared.context) {
        self.context = context
    }

    func insertCompany(name: String) {
        let company = Company(context: context)
        company.name = name

        do {
            try context.save()
            LoggingManager.shared.info("Successfully saved company: \(name)")
        } catch {
            LoggingManager.shared.error("Failed to save company: \(error)")
        }
    }

    func fetchDefaultCompany() -> Company? {
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

    func fetchCompany(forName name: String) -> Company? {
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
