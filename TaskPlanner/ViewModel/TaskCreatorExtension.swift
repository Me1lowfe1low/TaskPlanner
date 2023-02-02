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
        if taskList.tasks.count >= 1 {
            for ind in 0...taskList.tasks.count-1 {
                if taskList.tasks[ind].name != "" {
                    changeFlag = true
                }
            }
        }
        return taskList.title != "Title" || changeFlag
    }
   
    
    func saveMainTask() {
        if initialTaskWasChanged() {
            print("Preparing data for saving")
            let mainTask = MainTask(context: moc)
            mainTask.id = taskList.id
            mainTask.title = taskList.title
            mainTask.timestamp = taskList.timestamp
            print("Saving data with id: \(String(describing: mainTask.id?.uuidString))")
            
            if taskList.tasks.count >= 1 {
                for ind in 0...taskList.tasks.count-1 {
                    let subEmptyTask = SubTask(context: moc)
                    subEmptyTask.id = taskList.tasks[ind].id
                    subEmptyTask.name = taskList.tasks[ind].name
                    subEmptyTask.position = taskList.tasks[ind].position as NSNumber
                    subEmptyTask.isChecked = taskList.tasks[ind].isChecked as NSNumber
                    subEmptyTask.mainTask = mainTask
                    
                    try? moc.save()
                    print("Saving data with id: \(String(describing: subEmptyTask.id?.uuidString))")
                }
            } else {
                let subEmptyTask = SubTask(context: moc)
                taskList.tasks.append(Task(position: 0))
                subEmptyTask.id = taskList.tasks[0].id
                subEmptyTask.name = taskList.tasks[0].name
                subEmptyTask.position = taskList.tasks[0].position as NSNumber
                subEmptyTask.isChecked = taskList.tasks[0].isChecked as NSNumber
                subEmptyTask.mainTask = mainTask
                try? moc.save()
            }
            try? moc.save()
            
        }
    }
    
    func removeSubTask(at offsets: IndexSet) {
        taskList.tasks.remove(atOffsets: offsets)
        taskList.shiftPositionsOnRemoval(at: offsets.first!)
    }
    
    
    
    func move(from source: IndexSet, to destination: Int) {
        taskList.tasks.move(fromOffsets: source, toOffset: destination)
        taskList.shiftPositionsOnMove(at: destination, from: source.first!)
    }
}
