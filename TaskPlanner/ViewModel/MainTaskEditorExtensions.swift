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
        taskList.tasks = task.subTaskArray.map {
            Task(id: $0.id!, name: $0.name!, position: $0.wrappedPosition, isChecked: $0.wrappedCheck)
        }  
    }
    
    func saveChanges() {
        
        let compareSet = Set(task.subTaskArray.map { Task(id: $0.id!, name: $0.name!, position: $0.wrappedPosition, isChecked: $0.wrappedCheck) } )
        let resultExtraRecords = taskList.tasks.map{ Task(id: $0.id, name: $0.name, position: $0.position, isChecked: $0.isChecked) }.filter{ !compareSet.contains( $0 ) }  // Empty if there are no added subtasks or some initial subtasks were removed
        let resultRestRecords = task.subTaskArray.map{ Task(id: $0.id!, name: $0.name!, position: $0.wrappedPosition, isChecked: $0.wrappedCheck) }.filter{ taskList.tasks.map{ Task(id: $0.id, name: $0.name, position: $0.position, isChecked: $0.isChecked) }.contains($0) } // Empty if all initial tasks were removed
        let resultDeletedRecords = task.subTaskArray.map{ Task(id: $0.id!, name: $0.name!, position: $0.wrappedPosition, isChecked: $0.wrappedCheck) }.filter{ !taskList.tasks.map{ Task(id: $0.id, name: $0.name, position: $0.position, isChecked: $0.isChecked) }.contains( $0 ) }
        let result = resultRestRecords + resultExtraRecords
        
        if ( task.title! != taskList.title) {
            task.title = taskList.title
            try? moc.save()
        }
        
        if result.count >= 1 {
            if resultDeletedRecords.count >= 1 {
                for index in 0..<resultDeletedRecords.count {
                    moc.delete(task.subTaskArray.first{ $0.id == resultDeletedRecords[index].id }!)
                    
                }
                try? moc.save()
            }
            if resultExtraRecords.count >= 1 {
                for index in 0..<resultExtraRecords.count {
                    let subTask = SubTask(context: moc)
                    subTask.id = resultExtraRecords[index].id
                    subTask.name = resultExtraRecords[index].name
                    subTask.position = resultExtraRecords[index].position as NSNumber
                    subTask.isChecked = resultExtraRecords[index].isChecked as NSNumber
                    subTask.mainTask = task
                    subTask.mainTask?.id = task.id
                    subTask.mainTask?.title = task.title
                    subTask.mainTask?.timestamp = task.timestamp
                    
                    try? moc.save()
                }
            }
        }
        else {
            for index in stride(from: task.subTaskArray.count-1, through: 1, by: -1 ) {
                moc.delete(task.subTaskArray[index])
            }
            task.subTaskArray[0].name = ""
            
            try? moc.save()
            return
        }
        
    }
    
    func removeSubTask(at offsets: IndexSet) {
        taskList.tasks.remove(atOffsets: offsets)
        taskList.shiftPositionsOnRemoval(at: offsets.first!)
    }
    
    func removeTask(at offsets: IndexSet) {
        for index in offsets {
            let subTask = task.subTaskArray[index]
            moc.delete(subTask)
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        taskList.tasks.move(fromOffsets: source, toOffset: destination)
        taskList.shiftPositionsOnMove(at: destination, from: source.first!)
    }
}
