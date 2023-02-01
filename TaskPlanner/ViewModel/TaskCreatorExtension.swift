//
//  TaskCreatorExtension.swift
//  TaskPlanner
//
//  Created by Дмитрий Гордиенко on 01.02.2023.
//

import Foundation

extension TaskCreator {
    func initialTaskWasChanged() -> Bool {
        var changeFlag: Bool = false
        for ind in 0...taskList.tasks.count-1 {
            if taskList.tasks[ind].name != "" {
                changeFlag = true
            }
        }
        return taskList.title != "Title" && changeFlag
    }
   
    
    func saveMainTask() {
        if initialTaskWasChanged() {
            print("Preparing data for saving")
            let mainTask = MainTask(context: moc)
            mainTask.id = taskList.id
            mainTask.title = taskList.title
            mainTask.timestamp = taskList.timestamp
            print("Saving data with id: \(String(describing: mainTask.id?.uuidString))")
            
            for ind in 0...taskList.tasks.count-1 {
                let subEmptyTask = SubTask(context: moc)
                subEmptyTask.id = taskList.tasks[ind].id
                subEmptyTask.name = taskList.tasks[ind].name
                subEmptyTask.mainTask = mainTask
                
                
                try? moc.save()
                print("Saving data with id: \(String(describing: subEmptyTask.id?.uuidString))")
            }
            try? moc.save()
        }
    }
    
    func removeSubTask(at offsets: IndexSet) {
        taskList.tasks.remove(atOffsets: offsets)
    }
}
