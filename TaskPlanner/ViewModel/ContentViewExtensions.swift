//
//  ContentViewExtensions.swift
//  TaskPlanner
//
//  Created by Дмитрий Гордиенко on 01.02.2023.
//

import Foundation

extension ContentView {
    
    func deleteTask(at offsets: IndexSet) {
        for offset in offsets {
            let task = taskVault[offset]
            moc.delete(task)
        }
        
        try? moc.save()
    }

}
