// Created for TaskPlanner on 01.02.2023
// by Dmitry Gordienko
// git: https://github.com/Me1lowfe1low
// Using Swift 5.0
// Running on macOS 13.0
//
//  MainTaskEditor.swift
//  TaskPlanner
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes

import SwiftUI

struct MainTaskEditor: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataController: DataController
    @StateObject var taskList: Tasks = Tasks()
    @State var task: MainTask
    
    var body: some View {
        VStack( alignment: .leading) {
            List {
                TextField(task.title!, text: $taskList.title)
                    .font(.title)
                    .bold()
                    .padding()
                ForEach(taskList.tasks.indices, id: \.self) { index in
                    HStack {
                        Image(systemName: taskList.tasks[index].isChecked ? "checkmark.square" : "square")
                            .onTapGesture(perform: {
                                print("User tapped at \(taskList.tasks[index].position)")
                                taskList.tasks[index].isChecked.toggle()
                            })
                        Divider()
                        TextField( (index < task.subTaskArray.count) ? task.subTaskArray[index].wrappedName : "", text: $taskList.tasks[index].name)
                            .font(.callout)
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
                    taskList.tasks.append(Task(position: taskList.tasks.count ))
                }
            }
        }
        .onAppear(perform: { taskList.fillEntity(task) } )
        Button("Save") {
            dataController.saveOnEditChanges(moc, entryToRecord: taskList, initialValue: task)
            dismiss()
        }
        Text("")
    }
}
