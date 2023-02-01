//
//  MainTaskEditorExtensions.swift
//  TaskPlanner
//
//  Created by Дмитрий Гордиенко on 01.02.2023.
//

import Foundation

extension MainTaskEditor {
    
    func fillStruct() {
        taskList.title = task.title!
        taskList.tasks = task.subTaskArray.map { Task(id: $0.id!, name: $0.name!) }
    }
    
    func saveChanges() {
        if ( task.title! != taskList.title) {
            task.title = taskList.title
            try? moc.save()
        }
        
        let compareSet = Set(task.subTaskArray.map { Task(id: $0.id!, name: $0.name!) } )
        let resultExtraRecords = taskList.tasks.map{ Task(id: $0.id, name: $0.name) }.filter{ !compareSet.contains( $0 ) }  // Empty if there are no added subtasks or some initial subtasks were removed
        let resultRestRecords = task.subTaskArray.map{ Task(id: $0.id!, name: $0.name!) }.filter{ taskList.tasks.map{ Task(id: $0.id, name: $0.name) }.contains($0) } // Empty if all initial tasks were removed
        let resultDeletedRecords = task.subTaskArray.map{ Task(id: $0.id!, name: $0.name!) }.filter{ !taskList.tasks.map{ Task(id: $0.id, name: $0.name) }.contains( $0 ) }
        let result = resultRestRecords + resultExtraRecords
        
        /*
        print("Rest:")
        print(resultRestRecords.map { $0.name }, separator: " ")
        print("Deleted:")
        print(resultDeletedRecords.map { $0.name }, separator: " ")
        print("Extra:")
        print( resultExtraRecords.map { $0.name }, separator: " ")
        */
        
        if result.count >= 1 {
            if resultDeletedRecords.count >= 1 {
                for index in 0..<resultDeletedRecords.count {
                    print("Removing deleted samples...")
                    print(task.subTaskArray.first{ $0.id == resultDeletedRecords[index].id }!.name )
                    moc.delete(task.subTaskArray.first{ $0.id == resultDeletedRecords[index].id }!)
                    
                }
                try? moc.save()
                print("Removed deleted samples")
            }
            if resultExtraRecords.count >= 1 {
                print("Adding new samples, count: \(resultExtraRecords.count)")
                for index in 0..<resultExtraRecords.count {
                    print("Adding new samples...")
                    let subTask = SubTask(context: moc)
                    subTask.id = resultExtraRecords[index].id
                    subTask.name = resultExtraRecords[index].name
                    subTask.mainTask = task
                    subTask.mainTask?.id = task.id
                    subTask.mainTask?.title = task.title
                    subTask.mainTask?.timestamp = task.timestamp
                    print("Sample with id: \(resultRestRecords[index].id.uuidString) was added")
                    
                    try? moc.save()
                }
            }
        }
        else {
            print("Removing all subtasks")
            for index in stride(from: task.subTaskArray.count-1, through: 1, by: -1 )
            {
                print("\(index)")
                moc.delete(task.subTaskArray[index])
            }
            task.subTaskArray[0].name = ""
            
            try? moc.save()
            return
        }
        
    }
    
    func removeSubTask(at offsets: IndexSet) {
        taskList.tasks.remove(atOffsets: offsets)
    }
    
    func removeTask(at offsets: IndexSet) {
        for index in offsets {
            let subTask = task.subTaskArray[index]
            moc.delete(subTask)
        }
    }
}
