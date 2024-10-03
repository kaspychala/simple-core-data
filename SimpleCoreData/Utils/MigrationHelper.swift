//
//  MigrationHelper.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 03/10/2024.
//

import CoreData

protocol MigrationHelperProtocol {
    func setDefaultValues(context: NSManagedObjectContext)
}

class MigrationHelper: MigrationHelperProtocol {
    static let shared: MigrationHelperProtocol = MigrationHelper()

    private init() {}

    func setDefaultValues(context: NSManagedObjectContext) {
        createDefaultCompany(context: context)
    }

    private func createDefaultCompany(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", "Migration Company")

        do {
            let companies = try context.fetch(fetchRequest)
            if !companies.isEmpty {
                LoggingManager.shared.info("Default company already exists, no need to create it")
                return
            }
        } catch {
            LoggingManager.shared.info("Error fetching default company: \(error)")
        }

        let newDefaultCompany = Company(context: context)
        newDefaultCompany.name = "Migration Company"

        do {
            try context.save()
            LoggingManager.shared.info("Created default company: \(newDefaultCompany.name ?? "Unknown")")
        } catch let error as NSError {
            LoggingManager.shared.error("Could not create default company: \(error), \(error.userInfo)")
        }
    }
}
