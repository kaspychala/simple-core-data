//
//  EmployeeRepository.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import CoreData
import UIKit

protocol EmployeeRepositoryProtocol {
    func insertCheckInDate(_ date: String)
    func fetchLatestCheckInDate() -> String?
}

class EmployeeRepository: EmployeeRepositoryProtocol {

    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SimpleCoreData")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func insertCheckInDate(_ date: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context) else {
            return
        }
        let newEmployee = NSManagedObject(entity: entity, insertInto: context)
        newEmployee.setValue(date, forKey: "check_in_date_time")
        // Additional attribute for tracking insertion order to get the most recent date added when fetching
        newEmployee.setValue(Date(), forKey: "created_at")

        do {
            try context.save()
            LoggingManager.shared.info("Successfully saved check-in date")
        } catch let error as NSError {
            LoggingManager.shared.error("Could not save. \(error), \(error.userInfo)")
        }
    }

    func fetchLatestCheckInDate() -> String? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Employee")
        let sortDescriptor = NSSortDescriptor(key: "created_at", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchLimit = 1

        do {
            let employees = try context.fetch(fetchRequest)
            return employees.first?.value(forKey: "check_in_date_time") as? String
        } catch let error as NSError {
            LoggingManager.shared.error("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
}
