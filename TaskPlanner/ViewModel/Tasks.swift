// Created for TaskPlanner on 01.02.2023
// by Dmitry Gordienko
// git: https://github.com/Me1lowfe1low
// Using Swift 5.0
// Running on macOS 13.0
//
//  Tasks.swift
//  TaskPlanner
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes

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
    }
    
    func initialTaskWasChanged() -> Bool {
        var changeFlag: Bool = false
        if tasks.count >= 1 {
            for ind in 0...tasks.count-1 {
                if tasks[ind].name != "" {
                    changeFlag = true
                }
            }
        }
        return title != "Title" || changeFlag
    }
    
    func fillEntity(_ task: MainTask) {
        title = task.title!
        tasks = task.subTaskArray.map {
            Task(id: $0.id!, name: $0.name!, position: $0.wrappedPosition, isChecked: $0.wrappedCheck)
        }
    }
    
    func removeSubTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        shiftPositionsOnRemoval(at: offsets.first!)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        tasks.move(fromOffsets: source, toOffset: destination)
        shiftPositionsOnMove(at: destination, from: source.first!)
    }

}
