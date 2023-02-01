//
//  DataController.swift
//  TaskPlanner
//
//  Created by Дмитрий Гордиенко on 30.01.2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {

    let container = NSPersistentContainer(name: "TaskPlanner")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
