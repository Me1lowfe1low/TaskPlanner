//
//  MainTask+CoreDataProperties.swift
//  TaskPlanner
//
//  Created by Дмитрий Гордиенко on 31.01.2023.
//
//

import CoreData
import Foundation

extension MainTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainTask> {
        return NSFetchRequest<MainTask>(entityName: "MainTask")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?
    @NSManaged public var subTask: NSSet?
    
    public var wrappedId: UUID {
        id ?? UUID()
    }
    
    public var wrappedTimestamp: Date {
        timestamp ?? Date()
    }
    
    public var wrappedTitle: String {
        title ?? "Title"
    }
    
    public var subTaskArray: [SubTask] {
        let set = subTask as? Set<SubTask> ?? []
        
        return set.sorted  {
            $0.wrappedPosition < $1.wrappedPosition
        }
    }
}

// MARK: Generated accessors for subTask
extension MainTask {
    
    @objc(insertObject:inSubTaskAtIndex:)
    @NSManaged public func insertIntoSubTask(_ value: SubTask, at idx: Int)

    @objc(removeObjectFromSubTaskAtIndex:)
    @NSManaged public func removeFromSubTask(at idx: Int)

    @objc(insertSubTask:atIndexes:)
    @NSManaged public func insertIntoSubTask(_ values: [SubTask], at indexes: NSIndexSet)

    @objc(removeSubTaskAtIndexes:)
    @NSManaged public func removeFromSubTask(at indexes: NSIndexSet)

    @objc(replaceObjectInSubTaskAtIndex:withObject:)
    @NSManaged public func replaceSubTask(at idx: Int, with value: SubTask)

    @objc(replaceSubTaskAtIndexes:withSubTask:)
    @NSManaged public func replaceSubTask(at indexes: NSIndexSet, with values: [SubTask])

    @objc(addSubTaskObject:)
    @NSManaged public func addToSubTask(_ value: SubTask)

    @objc(removeSubTaskObject:)
    @NSManaged public func removeFromSubTask(_ value: SubTask)

    @objc(addSubTask:)
    @NSManaged public func addToSubTask(_ values: NSOrderedSet)

    @objc(removeSubTask:)
    @NSManaged public func removeFromSubTask(_ values: NSOrderedSet)

}

extension MainTask : Identifiable {

}
