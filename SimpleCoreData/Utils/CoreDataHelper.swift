//
//  CoreDataHelper.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 03/10/2024.
//

import CoreData
import UIKit

protocol CoreDataHelperProtocol {
    var context: NSManagedObjectContext { get }
    func saveContext()
}

class CoreDataHelper: CoreDataHelperProtocol {
    static let shared: CoreDataHelperProtocol = CoreDataHelper()

    private init() {
        MigrationHelper.shared.setDefaultValues(context: context)
    }

    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SimpleCoreData")

        // Lightweight migration
        container.persistentStoreDescriptions.forEach { description in
            description.shouldMigrateStoreAutomatically = true
            description.shouldInferMappingModelAutomatically = true
        }

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                LoggingManager.shared.info("Successfully saved the context.")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
