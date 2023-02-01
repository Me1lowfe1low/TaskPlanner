//
//  ContentViewExtensions.swift
//  TaskPlanner
//
//  Created by Дмитрий Гордиенко on 01.02.2023.
//

import Foundation

extension ContentView {
    
    func addDefaultTask() {
        let mainTask = MainTask(context: moc)
        mainTask.id = UUID()
        mainTask.title = "Title"
        mainTask.timestamp = Date()
        
        try? moc.save()
        
        let subEmptyTask = SubTask(context: moc)
        subEmptyTask.id = UUID()
        subEmptyTask.name = "Empty subTask name"
        subEmptyTask.mainTask = MainTask(context: moc)
        subEmptyTask.mainTask?.id = mainTask.id
        subEmptyTask.mainTask?.title = mainTask.title
        subEmptyTask.mainTask?.timestamp = mainTask.timestamp
        
        try? moc.save()
    }
    
    func deleteTask(at offsets: IndexSet) {
        for offset in offsets {
            let task = taskVault[offset]
            moc.delete(task)
        }
        
        try? moc.save()
    }

}
