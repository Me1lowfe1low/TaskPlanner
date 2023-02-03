// Created for TaskPlanner on 30.01.2023
// by Dmitry Gordienko
// git: https://github.com/Me1lowfe1low
// Using Swift 5.0
// Running on macOS 13.0
//
//  DataController.swift
//  TaskPlanner
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes

import CoreData
import Foundation

class DataController: ObservableObject {

    init(_ context: NSManagedObjectContext, container: NSPersistentContainer) {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }
            
            container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func assignValues(_ context: NSManagedObjectContext,_ task: Task,_ mainTask: MainTask) {
        let subEmptyTask = SubTask(context: context)
        subEmptyTask.id = task.id
        subEmptyTask.name = task.name
        subEmptyTask.position = task.position as NSNumber
        subEmptyTask.isChecked = task.isChecked as NSNumber
        subEmptyTask.mainTask = mainTask
        subEmptyTask.mainTask?.id = mainTask.id
        subEmptyTask.mainTask?.title = mainTask.title
        subEmptyTask.mainTask?.timestamp = mainTask.timestamp
        saveContext(context)
    }
    
    func deleteTask(_ context: NSManagedObjectContext, task: MainTask)
    {
        context.delete(task)
        saveContext(context)
    }
    
    func deleteSubTask(_ context: NSManagedObjectContext, task: SubTask)
    {
        context.delete(task)
        saveContext(context)
    }
    
    func deleteTask(_ context: NSManagedObjectContext, at offsets: IndexSet, tasks: [MainTask]) {
        for offset in offsets {
            let task = tasks[offset]
            deleteTask(context, task: task)
        }
    }
    
    func createMainTaskContext(_ context: NSManagedObjectContext, task: Tasks) -> MainTask {
        let mainTask = MainTask(context: context)
        mainTask.id = task.id
        mainTask.title = task.title
        mainTask.timestamp = task.timestamp
        return mainTask
    }
    
    func saveInitialChanges(_ context: NSManagedObjectContext, task: Tasks) {
        if task.initialTaskWasChanged() {
            let mainTask = createMainTaskContext(context, task: task)
            
            if task.tasks.count >= 1 {
                for ind in 0...task.tasks.count-1 {
                    assignValues(context,task.tasks[ind],mainTask)
                }
            } else {
                task.tasks.append(Task(position: 0))
                assignValues(context,task.tasks[0],mainTask)
            }
            saveContext(context)
        }
    }
    
    func saveOnEditChanges(_ context: NSManagedObjectContext, entryToRecord: Tasks, initialValue: MainTask) {
        let compareSet = Set(initialValue.subTaskArray.map {Task(id: $0.id!, name: $0.name!, position: $0.wrappedPosition, isChecked: $0.wrappedCheck)})
        let resultExtraRecords = entryToRecord.tasks.map{Task(id: $0.id, name: $0.name, position: $0.position, isChecked: $0.isChecked)}.filter{ !compareSet.contains( $0 ) }  // Empty if there are no added subtasks or some initial subtasks were removed
        let resultRestRecords = initialValue.subTaskArray.map{Task(id: $0.id!, name: $0.name!, position: $0.wrappedPosition, isChecked: $0.wrappedCheck) }.filter{ entryToRecord.tasks.map{ Task(id: $0.id, name: $0.name, position: $0.position, isChecked: $0.isChecked) }.contains($0) } // Empty if all initial tasks were removed
        let resultDeletedRecords = initialValue.subTaskArray.map{ Task(id: $0.id!, name: $0.name!, position: $0.wrappedPosition, isChecked: $0.wrappedCheck) }.filter{ !entryToRecord.tasks.map{ Task(id: $0.id, name: $0.name, position: $0.position, isChecked: $0.isChecked) }.contains( $0 ) }
        let result = resultRestRecords + resultExtraRecords
        
        if ( initialValue.title! != entryToRecord.title) {
            initialValue.title = entryToRecord.title
            saveContext(context)
        }
        
        if result.count >= 1 {
            if resultDeletedRecords.count >= 1 {
                for index in 0..<resultDeletedRecords.count {
                    deleteSubTask(context,task: initialValue.subTaskArray.first{ $0.id == resultDeletedRecords[index].id }!)
                }
            }
            if resultExtraRecords.count >= 1 {
                for index in 0..<resultExtraRecords.count {
                    assignValues(context,resultExtraRecords[index],initialValue)
                }
            }
        }
        else {
            for index in stride(from: initialValue.subTaskArray.count-1, through: 1, by: -1 ) {
                deleteSubTask(context,task: initialValue.subTaskArray[index])
            }
            initialValue.subTaskArray[0].name = ""
            saveContext(context)
            return
        }
    }
}
