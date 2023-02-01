//
//  SubTask+CoreDataProperties.swift
//  TaskPlanner
//
//  Created by Дмитрий Гордиенко on 31.01.2023.
//
//

import Foundation
import CoreData


extension SubTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubTask> {
        return NSFetchRequest<SubTask>(entityName: "SubTask")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var mainTask: MainTask?

    public var wrappedName: String {
        name ?? ""
    }
    
    public var wrappedId: UUID {
        id ?? UUID()
    }
}

extension SubTask : Identifiable {

}
