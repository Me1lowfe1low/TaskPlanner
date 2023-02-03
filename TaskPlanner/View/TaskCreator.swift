// Created for TaskPlanner on 30.01.2023
// by Dmitry Gordienko
// git: https://github.com/Me1lowfe1low
// Using Swift 5.0
// Running on macOS 13.0
//
//  TaskCreator.swift
//  TaskPlanner
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes


import SwiftUI

struct TaskCreator: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataController: DataController
    @FetchRequest(sortDescriptors: []) var taskVault: FetchedResults<MainTask>
    
    @StateObject var taskList: Tasks = Tasks()
    
    var body: some View {
        VStack( alignment: .leading) {
                
            List {
                TextField("Title", text: $taskList.title)
                    .font(.title)
                    .bold()
                    .padding()
                ForEach($taskList.tasks, id: \.id) { $task in
                    HStack {
                        Image(systemName: task.isChecked ? "checkmark.square" : "square")
                            .onTapGesture(perform: {
                                print("User tapped at \(task.position)")
                                task.isChecked.toggle()
                            })
                        Divider()
                        TextField("Sub-task title", text: $task.name)
                            .font(.caption)
                        Spacer()
                    }
                }
                .onMove(perform: taskList.move )
                .onDelete(perform: taskList.removeSubTask )
                HStack( alignment: .top) {
                    Label("",systemImage: "plus")
                    Text("List sub task")
                }
                .padding(.horizontal)
                .onTapGesture {
                    taskList.tasks.append(Task(position: taskList.tasks.count))
                }
                
            }
        }
        Button("Save") {
            dataController.saveInitialChanges(moc,task: taskList)
            dismiss()
        }
    }
}
   

struct TaskCreator_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            TaskCreator()
        }
    }
}
