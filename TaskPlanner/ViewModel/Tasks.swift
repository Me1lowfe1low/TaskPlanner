//
//  Tasks.swift
//  TaskPlanner
//
//  Created by Дмитрий Гордиенко on 01.02.2023.
//

import Foundation
import CoreData

class Tasks: ObservableObject {
    @Published var id: UUID = UUID()
    @Published var timestamp: Date = Date()
    @Published var title = "Title"
    @Published var tasks = [Task]()
    
    func sortSubTasks() {
        self.tasks = tasks.sorted  {
            $0.position < $1.position
        }
    }
    
    func shiftPositionsOnRemoval(at index: Int) {
        if tasks.count >= 1 && index != tasks.count {
            for index in index...tasks.count-1 {
                   tasks[index].position -= 1
            }
        }
    }
    
    func shiftPositionsOnMove(at index: Int, from sourceInd: Int) {
        if tasks.count >= 1 {
            if index < sourceInd && index != tasks.count {
                let nextIndex = index+1
                for index in nextIndex...sourceInd {
                    tasks[index].position += 1
                }
                tasks[index].position = index
            }
            else {
                for ind in sourceInd...index-1 {
                    tasks[ind].position -= 1
                }
                tasks[index-1].position = index-1
                if index != tasks.count {
                    tasks[index].position = index
                }
            }
        }
        print("Sort completed")
    }
}
