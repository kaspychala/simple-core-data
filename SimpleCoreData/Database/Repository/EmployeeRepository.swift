//
//  EmployeeRepository.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import CoreData

protocol EmployeeRepositoryProtocol {
    func insertCheckInDate(_ date: String, forCompany company: Company)
    func fetchLatestCheckInDate() -> String?
    func fetchEmployees(forCompany company: Company) -> [Employee]
}

class EmployeeRepository: EmployeeRepositoryProtocol {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataHelper.shared.context) {
        self.context = context
    }

    func insertCheckInDate(_ date: String, forCompany company: Company) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context) else {
            return
        }

        let newEmployee = NSManagedObject(entity: entity, insertInto: context) as? Employee
        newEmployee?.check_in_date_time = date
        // Additional attribute for tracking insertion order to get the most recent date added when fetching
        newEmployee?.created_at = Date()
        newEmployee?.company = company

        do {
            try context.save()
            LoggingManager.shared.info("Successfully saved check-in date for company: \(company.name ?? "Unknown")")
        } catch let error as NSError {
            LoggingManager.shared.error("Could not save. \(error), \(error.userInfo)")
        }
    }

    func fetchLatestCheckInDate() -> String? {
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        let sortDescriptor = NSSortDescriptor(key: "created_at", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchLimit = 1

        do {
            let employees = try context.fetch(fetchRequest)
            return employees.first?.check_in_date_time
        } catch let error as NSError {
            LoggingManager.shared.error("Could not fetch the latest check-in date. \(error), \(error.userInfo)")
            return nil
        }
    }

    func fetchEmployees(forCompany company: Company) -> [Employee] {
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        fetchRequest.predicate = NSPredicate(format: "company == %@", company)

        do {
            let employees = try context.fetch(fetchRequest)
            return employees
        } catch let error as NSError {
            LoggingManager.shared.error("Could not fetch employees for company: \(error), \(error.userInfo)")
            return []
        }
    }
}
